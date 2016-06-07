# coding: utf-8
class Project < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include ERB::Util
  include Rails.application.routes.url_helpers

  acts_as_taggable_on :tags

  mount_uploader :logo, LogoUploader

  belongs_to :user
  belongs_to :leader, :class_name => "User", :foreign_key => "leader_id"
  belongs_to :category
  has_many :projects_curated_pages
  has_many :curated_pages, :through => :projects_curated_pages
  has_many :backers, :dependent => :destroy
  has_many :rewards, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :dynamic_fields, :dependent => :destroy
  has_one :project_total
  has_and_belongs_to_many :managers, :join_table => "projects_managers", :class_name => 'User'
  accepts_nested_attributes_for :rewards, :dynamic_fields

  has_vimeo_video :video_url, :message => I18n.t('project.vimeo_regex_validation')

  auto_html_for :about do
    html_escape :map => {
      '&' => '&amp;',
      '>' => '&gt;',
      '<' => '&lt;',
      '"' => '"' }
    image
    youtube
    vimeo
    redcarpet :target => :_blank
    link :target => :_blank
  end

  def youtube_embed
    if vimeo.youtube_video?
      auto_html(video_url) { youtube width: 614, height: 355, wmode: "opaque" }
    else
      ''
    end
  end

  # These two fields are for having expires_at on_the_spot editing
  # with a pretty display format
  def expires_at_spot
    expires_at.strftime('%d/%m/%Y')
  end

  def expires_at_spot=(value)
    self.expires_at = "#{value} 11:59"
  end

  scope :visible, where(visible: true)
  scope :recommended, where(recommended: true)
  scope :expired, where("finished OR expires_at < current_timestamp")
  scope :not_expired, where("finished = false AND expires_at >= current_timestamp")
  scope :expiring, not_expired.where("expires_at < (current_timestamp + interval '2 weeks')")
  scope :not_expiring, not_expired.where("NOT (expires_at < (current_timestamp + interval '2 weeks'))")
  scope :recent, where("current_timestamp - projects.created_at <= '15 days'::interval")
  scope :successful, where(successful: true)
  scope :recommended_for_home, ->{
    includes(:user, :category, :project_total).
    recommended.
    visible.
    not_expired.
    order('random()').
    limit(4)
  }
  scope :expiring_for_home, ->(exclude_ids){
    includes(:user, :category, :project_total).where("coalesce(id NOT IN (?), true)", exclude_ids).visible.expiring.order('date(expires_at), random()').limit(3)
  }
  scope :recent_for_home, ->(exclude_ids){
    includes(:user, :category, :project_total).where("coalesce(id NOT IN (?), true)", exclude_ids).visible.recent.not_expiring.order('date(created_at) DESC, random()').limit(3)
  }

  search_methods :visible, :recommended, :expired, :not_expired, :expiring, :not_expiring, :recent, :successful

  validates_presence_of :name, :user, :category, :about, :headline, :goal, :expires_at, :when_short, :when_long, :location, :leader
  validates_length_of :headline, :maximum => 140
  validates_uniqueness_of :permalink, :allow_blank => true, :allow_nil => true
  validates_numericality_of :maximum_backers, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_format_of :image_url, :with => /\.(jpg|jpeg|png|gif)$/, :allow_blank => true
  before_create :store_image_url

  # Store the image URL if no image was uploaded
  # If there's no upload and no URL, store the default image
  def store_image_url
    if logo.url.blank?
      self.image_url = display_image
    end
  end

  def has_dynamic_fields?
    true if dynamic_fields.count > 0
  end

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def display_image
    if logo.url.present?
      logo.url
    elsif image_url.present?
      image_url
    elsif vimeo.thumbnail.present?
      vimeo.thumbnail
    else
      image_path('nosvc/default_images/1.jpg')
    end
  end

  def display_expires_at
    I18n.l(expires_at.to_date)
  end

  def display_pledged
    number_to_currency pledged, :unit => 'R$', :precision => 0, :delimiter => '.'
  end

  # Temporary HACK
  # Used to display the 'goal' correctly as integer in on_the_spot edits
  def goal
    read_attribute(:goal).to_i if read_attribute(:goal).present?
  end

  def display_goal
    goal
    #number_to_currency goal, :unit => 'R$', :precision => 0, :delimiter => '.'
  end

  def pledged
    project_total ? project_total.pledged : 0.0
  end

  def participants
    return total_backers
  end

  def missing_participants
    goal.to_i - participants
  end

  def display_missing_participants
    missing_participants
  end

  def confirmed?
    return true if missing_participants <= 0
    false
  end

  def total_backers
    project_total ? project_total.total_backers : 0
  end

  def leader_name
     (leader.display_name if leader) || user.display_name
  end

  def display_status
    if successful? and expired?
      'successful'
    elsif expired?
      'expired'
    elsif waiting_confirmation?
      'waiting_confirmation'
    elsif in_time? and successful?
      'successful'
    elsif in_time?
      'in_time'
    end
  end

  def successful?
    return successful if finished
    confirmed?
  end

  def expired?
    finished || expires_at < Time.now
  end

  def waiting_confirmation?
    return false if finished or successful?
    expired? and Time.now < 3.weekdays_from(expires_at)
  end

  def in_time?
    !expired?
  end

  def progress
    ((pledged / goal * 100).abs).round.to_i
  end

  def display_progress
    return 100 if successful?
    return 8 if progress > 0 and progress < 8
    progress
  end

  def time_to_go
    if expires_at >= 1.day.from_now
      time = ((expires_at - Time.now).abs/60/60/24).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.day').downcase)}
    elsif expires_at >= 1.hour.from_now
      time = ((expires_at - Time.now).abs/60/60).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.hour').downcase)}
    elsif expires_at >= 1.minute.from_now
      time = ((expires_at - Time.now).abs/60).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.minute').downcase)}
    elsif expires_at >= 1.second.from_now
      time = ((expires_at - Time.now).abs).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.second').downcase)}
    else
      {:time => 0, :unit => pluralize_without_number(0, I18n.t('datetime.prompts.second').downcase)}
    end
  end

  def remaining_text
    pluralize_without_number(time_to_go[:time], I18n.t('remaining_singular'), I18n.t('remaining_plural'))
  end

  def can_back?
    visible? and not expired? and not rejected? and vacancies? and rewards.not_expired.count > 0
  end

  def vacancies?
    return true if total_vacancies == true or (total_vacancies != false and total_vacancies > 0)
    false
  end

  def unlimited_vacancies?
    return false if maximum_backers
    return false unless unlimited_vacancies_from_rewards?
    true
  end

  def unlimited_vacancies_from_rewards?
    rewards.not_expired.each do |reward|
      return true unless reward.maximum_backers
    end
    false
  end

  def total_vacancies
    total_from_rewards = (total_vacancies_from_rewards unless unlimited_vacancies_from_rewards?) || false
    total = (maximum_backers - backers.confirmed.count if maximum_backers) || false
    if total == false and not total_from_rewards == false
      return total_from_rewards
    elsif not total == false and total_from_rewards == false
      return total
    elsif not total == false and not total_from_rewards == false
      return (total if total < total_from_rewards) || total_from_rewards
    elsif total == false and total_from_rewards == false
      return true
    end
    false
  end

  def vacancies_from_rewards?
    unless unlimited_vacancies_from_rewards?
      return true if total_vacancies_from_rewards > 0
    end
  end

  def total_vacancies_from_rewards
    return false if unlimited_vacancies_from_rewards?
    total = 0
    rewards.each do |reward|
      total += reward.maximum_backers if reward.maximum_backers
    end
    total - backers.confirmed.count
  end

  # Sum the values for all confirmed registrations
  def expected_revenue
    payment_method_fee = Configuration.find_by_name('payment_method_fee')

    payment_method_fee = if payment_method_fee.present?
      (payment_method_fee.value.to_f/100.0)
    else
      0.075
    end

    backers.confirmed.sum(:value) * (1 - payment_method_fee)
  end

  def display_expected_revenue
    number_to_currency expected_revenue, :unit => 'R$', :precision => 2, :delimiter => '.'
  end

  def finish!
    return unless expired? and can_finish and not finished
    backers.confirmed.each do |backer|
      unless backer.can_refund or backer.notified_finish
        if successful?
          notification_text = I18n.t('project.finish.successful.notification_text', :link => link_to(truncate(name, :length => 38), "/projects/#{self.to_param}"), :locale => backer.user.locale)
          twitter_text = I18n.t('project.finish.successful.twitter_text', :name => name, :short_url => short_url, :locale => backer.user.locale)
          facebook_text = I18n.t('project.finish.successful.facebook_text', :name => name, :locale => backer.user.locale)
          email_subject = I18n.t('project.finish.successful.email_subject', :locale => backer.user.locale)
          email_text = I18n.t('project.finish.successful.email_text', :project_link => link_to(name, "#{I18n.t('site.base_url')}/projects/#{self.to_param}", :style => 'color: #008800;'), :user_link => link_to(user.display_name, "#{I18n.t('site.base_url')}/users/#{user.to_param}", :style => 'color: #008800;'), :locale => backer.user.locale)
          backer.user.notifications.create :project => self, :text => notification_text, :twitter_text => twitter_text, :facebook_text => facebook_text, :email_subject => email_subject, :email_text => email_text
          if backer.reward
            notification_text = I18n.t('project.finish.successful.reward_notification_text', :link => link_to(truncate(user.display_name, :length => 32), "/users/#{user.to_param}"), :locale => backer.user.locale)
            backer.user.notifications.create :project => self, :text => notification_text
          end
        else
          notification_text = I18n.t('project.finish.unsuccessful.unsuccessful_text', :link => link_to(truncate(name, :length => 32), "/projects/#{self.to_param}"), :locale => backer.user.locale)
          backer.user.notifications.create :project => self, :text => notification_text
          notification_text = I18n.t('project.finish.unsuccessful.notification_text', :value => backer.display_value, :link => link_to(I18n.t('here', :locale => backer.user.locale), "#{I18n.t('site.base_url')}/users/#{backer.user.to_param}#credits"), :locale => backer.user.locale)
          email_subject = I18n.t('project.finish.unsuccessful.email_subject', :locale => backer.user.locale)
          email_text = I18n.t('project.finish.unsuccessful.email_text', :project_link => link_to(name, "#{I18n.t('site.base_url')}/projects/#{self.to_param}", :style => 'color: #008800;'), :value => backer.display_value, :credits_link => link_to(I18n.t('clicking_here', :locale => backer.user.locale), "#{I18n.t('site.base_url')}/users/#{backer.user.to_param}#credits", :style => 'color: #008800;'), :locale => backer.user.locale)
          backer.user.notifications.create :project => self, :text => notification_text, :email_subject => email_subject, :email_text => email_text
          backer.update_attributes({ can_refund: true })
        end
        backer.update_attributes({ notified_finish: true })
      end
    end
    self.update_attributes finished: true, successful: successful?
  end

  def as_json(options={})
    {
      id: id,
      name: name,
      user: user,
      leader_name: leader_name,
      category: category,
      image: display_image,
      headline: headline,
      progress: progress,
      display_progress: display_progress,
      pledged: display_pledged,
      created_at: created_at,
      time_to_go: time_to_go,
      remaining_text: remaining_text,
      url: (self.permalink.blank? ? "/projects/#{self.to_param}" : '/' + self.permalink),
      full_uri: I18n.t('site.base_url') + (self.permalink.blank? ? Rails.application.routes.url_helpers.project_path(self) : '/' + self.permalink),
      expired: expired?,
      can_back: can_back?,
      successful: successful?,
      waiting_confirmation: waiting_confirmation?,
      display_status_to_box: I18n.t("project.display_status.#{display_status}").capitalize,
      display_missing_participants_to_box: I18n.t('projects.project.missing_participants', count: display_missing_participants).html_safe,
      class_status: successful? ? 'confirmed' : 'not_confirmed',
      display_expires_at: display_expires_at,
      in_time: in_time?,
      when_short: when_short
    }
  end

end

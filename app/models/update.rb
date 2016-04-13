class Update < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates_presence_of :user_id, :project_id, :comment, :comment_html
  after_create :notify_backers

  auto_html_for :comment do
    html_escape :map => {
      '&' => '&amp;',
      '>' => '&gt;',
      '<' => '&lt;',
      '"' => '"' }
    image
    youtube width: 614, height: 355, wmode: "opaque"
    vimeo width: 614, height: 355
    redcarpet :target => :_blank
    link :target => :_blank
  end

  protected
  def notify_backers
    project.backers.confirmed.each do |backer|
      text = I18n.t('notifications.updates.text',
                    :update_title => title,
                    :update_text => auto_html(comment) { link; redcarpet; },
                    :project_link => Rails.application.routes.url_helpers.project_url(project, :host => I18n.t('site.host')),
                    :project_name => project.name)
      Notification.create! :user => backer.user,
                           :email_subject => I18n.t('notifications.updates.subject',
                                                    :project_name => project.name,
                                                    :project_owner => project.user.display_name,
                                                    :update_title => title),
                           :email_text => text,
                           :text => text
    end
  end

end

# coding: utf-8
class ProjectsController < ApplicationController
  include ActionView::Helpers::DateHelper

  inherit_resources
  actions :index, :show, :new, :create
  respond_to :html, :except => [:backers]
  respond_to :json, :only => [:index, :show, :backers]
  can_edit_on_the_spot
  skip_before_filter :detect_locale, :only => [:backers]
  before_filter :can_update_on_the_spot?, :only => :update_attribute_on_the_spot
  before_filter :date_format_convert, :only => [:create]

  before_filter :load_past_locations, :only => [:new]

  def date_format_convert
    # TODO localize here and on the datepicker on project_form.js
    params["project"]["expires_at"] = Date.strptime(params["project"]["expires_at"], '%d/%m/%Y')
    params["project"]["rewards_attributes"].each_with_index do |value, index|
      params["project"]["rewards_attributes"][index.to_s]["expires_at"] = Date.strptime(params["project"]["rewards_attributes"][index.to_s]["expires_at"], '%d/%m/%Y') + 23.hours + 59.minutes if params["project"]["rewards_attributes"][index.to_s]["expires_at"].present?
    end
  end

  def index
    index! do |format|
      format.html do
        @title = t("site.title")

        @curated_pages = CuratedPage.visible.order("created_at desc")
        collection_projects = Project.recommended_for_home
        unless collection_projects.empty?
          @first_project, @second_project, @third_project, @fourth_project = collection_projects.all
        end

        project_ids = collection_projects.map{|p| p.id }

        @expiring = Project.expiring_for_home(project_ids)
        @recent = Project.recent_for_home(project_ids)

        @blog_posts = Blog.fetch_last_posts.inject([]) do |total,item|
          if total.size < 2
            total << item
          end
          total
        end || []

        calendar = Calendar.new
        @events = Rails.cache.fetch 'calendar', expires_in: 30.minutes do
          calendar.fetch_events_from("catarse.me_237l973l57ir0v6279rhrr1qs0@group.calendar.google.com") || []
        end
        @curated_pages = CuratedPage.visible.order("created_at desc").limit(8)
        @last_tweets = Rails.cache.fetch('last_tweets', :expires_in => 30.minutes) do
          begin
            JSON.parse(Net::HTTP.get(URI("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#{t('site.twitter')}")))[0..1]
          rescue
            []
          end
        end
        @last_tweets ||= []
      end
      format.json do
        # After the search params we order by ID to avoid ties and therefore duplicate items in pagination
        @projects = Project.visible.search(params[:search]).order('id').page(params[:page]).per(6)
        respond_with(@projects)
      end
    end
  end

  def new
    return unless require_login
    new! do
      @title = t('projects.new.title').gsub(/<\/?[^>]*>/, "")
      @project.rewards.build
      @project.dynamic_fields.build()
    end
  end

  def create
    params[:project][:expires_at] += (23.hours + 59.minutes + 59.seconds) if params[:project][:expires_at]
    validate_rewards_attributes if params[:project][:rewards_attributes].present?
    params[:project].delete(:dynamic_fields_attributes) unless params[:has_dynamic_fields]
    create!{ |format|
      format.html { redirect_to root_path, :notice => t('projects.create.success') }
    }
    # When it can't create the project the @project doesn't exist and then it causes a record not found
    # because @project.reload *works only with created records*
    unless @project.new_record?
      @project.reload
      @project.update_attributes({ short_url: bitly })
      ProjectsMailer.new_project(params[:project][:name], project_url(@project), @project, current_user).deliver
    end
  end

  def show
    begin
      if params[:permalink].present?
        @project = Project.find_by_permalink! params[:permalink]
      elsif resource.permalink.present?
        return redirect_to project_by_slug_path(resource.permalink)
      end

      @project = Project.find params[:id] if params[:id].present?
      @link = @project
      if !params[:permalink].present? and @project.permalink.present?
        @link = project_by_slug_url(permalink: @project.permalink)
        return redirect_to project_by_slug_url(permalink: @project.permalink)
      end

      if params[:token].present?
        session[:token] = params[:token]
        return redirect_to @link
      end

      show!{
        @rewards = []
        if session[:token].present?
          @rewards = @project.rewards.with_token session[:token]
        end
        @title = @project.name
        @rewards.concat @project.rewards.order(:minimum_value).public
        @backers = @project.backers.confirmed.limit(12).order("confirmed_at DESC").all
        fb_admins_add(@project.user.facebook_id) if @project.user.facebook_id
      }
    rescue ActiveRecord::RecordNotFound
      return render_404
    end
  end

  def vimeo
    project = Project.new(:video_url => params[:url])
    if project.vimeo.info
      render :json => project.vimeo.info.to_json
    else
      render :json => {:id => false}.to_json
    end
  end

  def cep
    address = BuscaEndereco.por_cep(params[:cep])
    render :json => {
      :ok => true,
      :street => "#{address[0]} #{address[1]}",
      :neighbourhood => address[2],
      :state => address[3],
      :city => address[4]
    }.to_json
  rescue
    render :json => {:ok => false}.to_json
  end

  def embed
    @project = Project.find params[:id]
    @title = @project.name
    render :layout => 'embed'
  end

  def video_embed
    @project = Project.find params[:id]
    @title = @project.name
    render :layout => 'embed'
  end

  def pending
    return unless require_admin
    @title = t('projects.pending.title')
    @search = Project.search(params[:search])
    @projects = @search.order('projects.created_at DESC').page(params[:page])
  end

  def pending_backers
    return unless require_admin
    @title = t('projects.pending_backers.title')
    @search = Backer.search(params[:search])
    @backers = @search.order("created_at DESC").page(params[:page])
  end


  private

  # Used to show other past event locations to the users
  # in the project creation form
  def load_past_locations
    id = current_user.try(:id)
    past_projects = Project.where('leader_id = ? OR user_id = ?', id, id).order('created_at DESC').limit(3)
    @past_locations = past_projects.pluck(:location).uniq
  end

  # Just to fix a minor bug,
  # when user submit the project without some rewards.
  def validate_rewards_attributes
    rewards = params[:project][:rewards_attributes]
    rewards.each do |r|
      rewards.delete(r[0]) unless Reward.new(r[1]).valid?
    end
  end

  def bitly
    return unless Rails.env.production?
    require 'net/http'
    res = Net::HTTP.start("api.bit.ly", 80) { |http| http.get("/v3/shorten?login=nosvc&apiKey=R_2ba4fd974ddbfe4fe60c997860a9a3f8&longUrl=#{CGI.escape(project_url(@project))}") }
    data = JSON.parse(res.body)['data']
    data['url'] if data
  end

  def can_update_on_the_spot?
    project_fields = ["name", "about", "headline", "expires_at_spot", "image_url", "video_url", "location", "when_short", "when_long", "leader_bio"]
    project_admin_fields = ["name", "about", "headline", "can_finish", "expires_at_spot", "user_id", "image_url", "video_url", "visible", "rejected", "recommended", "home_page",  "permalink", "when_short", "when_long", "leader_bio", "leader_id", "location"]
    backer_fields = ["display_notice"]
    backer_admin_fields = ["confirmed", "requested_refund", "refunded", "anonymous", "user_id"]
    reward_fields = ["description"]
    reward_admin_fields = ["description"]
    def render_error; render :text => t('require_permission'), :status => 422; end
    return render_error unless current_user
    klass, field, id = params[:id].split('__')
    return render_error unless klass == 'project' or klass == 'backer' or klass == 'reward'
    if klass == 'project'
      return render_error unless project_fields.include?(field) or (current_user.admin and project_admin_fields.include?(field))
      project = Project.find id
      return render_error unless current_user.can_manage_project?(project) or current_user.admin
    elsif klass == 'backer'
      return render_error unless backer_fields.include?(field) or (current_user.admin and backer_admin_fields.include?(field))
      backer = Backer.find id
      return render_error unless current_user.admin or (backer.user == current_user)
    elsif klass == 'reward'
      return render_error unless reward_fields.include?(field) or (current_user.admin and reward_admin_fields.include?(field))
      reward = Reward.find id
      return render_error unless current_user.can_manage_project?(reward.project) or current_user.admin
    end
  end
end

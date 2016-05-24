# Encoding: utf-8
class Projects::BackersController < ApplicationController
  inherit_resources
  actions :index, :new
  before_filter :load_project

  def index
    @backers = @project.backers.confirmed.order("confirmed_at DESC").page(params[:page]).per(20)
    can_manage = can?(:manage, @project)

    respond_to do |format|
      format.html { redirect_to(login_path) unless can_manage }
      format.json { render :json => @backers.to_json(:can_manage => can_manage) }
    end
  end

  def new
    return unless require_login
    unless @project.can_back?
      flash[:failure] = t('projects.back.cannot_back')
      return redirect_to :root
    end
    @title = t('projects.backers.new.title', :name => @project.name)
    @backer = @project.backers.new(:user => current_user)
    #empty_reward = Reward.new(:id => 0, :minimum_value => 0, :description => t('projects.backers.new.no_reward'))
    @rewards = []
    if session[:token].present?
      @rewards = @project.rewards.with_token session[:token]
    end
    @rewards.concat @project.rewards.not_expired.order(:minimum_value).public
    @reward = @project.rewards.find params[:reward_id] if params[:reward_id]
    @reward = nil if @reward and @reward.sold_out?
    if @reward
      @backer.reward = @reward
      @backer.value = "%0.0f" % @reward.minimum_value
    end
  end

  def review
    return unless require_login

    @title = t('projects.backers.review.title')
    params[:backer][:reward_id] = nil if params[:backer][:reward_id] == '0'
    params[:backer][:user_id] = current_user.id
    @project = Project.find params[:project_id]
    backer_data = params[:backer]
    backer_data[:value] = Reward.find(backer_data[:reward_id]).minimum_value
    @backer = @project.backers.new(backer_data)

    unless @backer.save
      raise @backer.errors.inspect
      flash[:failure] = t('projects.backers.review.error')
      return redirect_to new_project_backer_path(@project)
    end
    if @backer.project.has_dynamic_fields?
      @backer.project.dynamic_fields.order(:created_at).each do |dynamic_field|
        @backer.dynamic_values.build dynamic_field_id: dynamic_field.id
      end
    end
    session[:thank_you_id] = @project.id
  end

  def checkout
    return unless require_login
    backer = current_user.backs.find params[:id]
    session[:token] = nil # remove the token of reward
    # reward free
    if backer.value == 0
      current_user.update_attributes params[:user]
      update_dynamic_values_attributes backer
      unless backer.confirmed
        backer.update_attribute :payment_method, 'Free'
        backer.confirm!
      end
      flash[:success] = t('projects.backers.checkout.success')
      return redirect_to thank_you_path
    end

    if params[:payment_method_url].present?
      current_user.update_attributes params[:user]
      current_user.reload
      update_dynamic_values_attributes backer
      return redirect_to params[:payment_method_url]
    else
      if backer.credits
        if current_user.credits < backer.value
          flash[:failure] = t('projects.backers.checkout.no_credits')
          return redirect_to new_project_backer_path(backer.project)
        end
        unless backer.confirmed
          current_user.credits = (current_user.credits - backer.value)
          current_user.save
          backer.update_attributes({ payment_method: 'Credits' })
          backer.confirm!
        end
        flash[:success] = t('projects.backers.checkout.success')
        redirect_to thank_you_path
      end
    end
  end

  private
  def update_dynamic_values_attributes backer
    backer.update_attributes({:dynamic_values_attributes => params[:backer][:dynamic_values_attributes]}) if params[:backer].present? and params[:backer][:dynamic_values_attributes].present?
  end
  def load_project
    @project = Project.find params[:project_id]
  end
end

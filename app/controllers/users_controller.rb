# coding: utf-8
class UsersController < ApplicationController
  load_and_authorize_resource except: :update_attribute_on_the_spot
  inherit_resources
  actions :show, :update
  can_edit_on_the_spot
  before_filter :can_update_on_the_spot?, :only => :update_attribute_on_the_spot
  before_filter :filter_mass_assignment, :only => [:update, :create]

  respond_to :json, :only => [:backs, :projects, :request_refund, :index]

  def index
    if params[:q].present?
      @users = User.where("name ILIKE ? OR full_name ILIKE ? OR nickname ILIKE ?",
        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    @users = @users.order('name ASC').page(params[:page]).per(10)

    respond_with do |format|
      format.json do
        render :json => {
            :items => @users.map(&:as_json),
            :total_count => @users.total_count
          }
      end
    end
  end

  def show
    show!{
      return redirect_to(user_path(@user.primary)) if @user.primary
      fb_admins_add(@user.facebook_id) if @user.facebook_id
      @title = "#{@user.display_name}"
      @credits = @user.backs.can_refund.within_refund_deadline.all
    }
  end

  def update
    update! do
      flash[:notice] = t('users.current_user_fields.updated')
      return redirect_to user_path(@user, :anchor => 'settings')
    end
  end

  def projects
    @user = User.find(params[:id])
    @projects = @user.projects.order("updated_at DESC")
    @projects = @projects.visible unless @user == current_user
    @projects = @projects.page(params[:page]).per(10)
    render :json => @projects
  end

  def credits
    @user = User.find(params[:id])
    @credits = @user.backs.can_refund.within_refund_deadline.order(:id).all
    render :json => @credits
  end

  def request_refund
    back = Backer.find(params[:back_id])
    begin
      refund = Credits::Refund.new(back, current_user)
      refund.make_request!
      status = refund.message
    rescue Exception => e
      status = e.message
    end

    render :json => {:status => status, :credits => current_user.reload.display_credits}
  end

  private
  def can_update_on_the_spot?
    user_fields = ["email", "name", "bio", "newsletter", "project_updates"]
    notification_fields = ["dismissed"]
    def render_error; render :text => t('require_permission'), :status => 422; end
    return render_error unless current_user
    klass, field, id = params[:id].split('__')
    return render_error unless klass == 'user' or klass == 'notification'
    if klass == 'user'
      return render_error unless user_fields.include? field
      user = User.find id
      return render_error unless current_user.id == user.id or current_user.admin
    elsif klass == 'notification'
      return render_error unless notification_fields.include? field
      notification = Notification.find id
      return render_error unless current_user.id == notification.user.id
    end
  end

  # TODO: use real rails4 style strong parameters
  def filter_mass_assignment
    # For now admin is set as attr_accesible to allow rails_admin to update,
    # but this means we have to filter it out here.
    params[:user][:admin] = nil
  end
end

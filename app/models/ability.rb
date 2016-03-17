# coding: utf-8
class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can :show, User
    can :manage, User, :id => current_user.id
    can :request_refund, Backer, :user_id => current_user.id
    can :backs, User
    can :projects, User

    if current_user.persisted?
      can :index, User
    end

    if current_user.admin?
      can :manage, :all
    else
      can :manage, Project do |project|
        can_manage_project?(current_user, project)
      end
      can :manage, Reward do |reward|
        can_manage_project?(current_user, reward.project)
      end
    end
  end

  private
  def can_manage_project?(user, project)
    user.manages_project_ids.include?(project.id) || [project.leader_id, project.user_id].include?(user.id)
  end
end

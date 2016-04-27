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

    can :show, CuratedPage, :visible => true

    if current_user.persisted?
      can :index, User
    end

    if current_user.admin?
      can :manage, :all
    else
      can :manage, Project do |project|
        current_user.can_manage_project?(project)
      end
      can :manage, Reward do |reward|
        current_user.can_manage_project?(reward.project)
      end
    end
  end

end

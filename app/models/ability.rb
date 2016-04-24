class Ability
  include CanCan::Ability
    def initialize(user)
      can :read, :all

      if user && user.role?(:admin)
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      elsif user && user.role?(:user)
        can :create, [Post, Comment]
        can :update, Post, user_id: user.id
        can :update, User, id: user.id
        can [:destroy], Comment, user_id: user.id
      elsif user && user.role?(:moderator)
        can :manage, [Post, Comment]
    end
  end
end


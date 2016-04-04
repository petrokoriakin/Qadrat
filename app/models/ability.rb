class Ability
  include CanCan::Ability
    def initialize(user)
        can :read, :all

        if user && user.role?(:admin)
            can :access, :rails_admin
            can :dashboard
            can :manage, :all
        elsif user && user.role?(:user)
            can :read, :all
            can :create, :all
            can :update, Post, user_id: user.id
            can [:update, :destroy], Comment, user_id: user.id
        elsif user && user.role?(:moderator)
            can :manage, :all
        end
    end
end

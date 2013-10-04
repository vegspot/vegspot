class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Admin user
    if user.is_admin?
      can :manage, :all
    end

    # Anyone
    can :read, :all

    # Regular logged in user
    if user.persisted?
      can :create, Comment
      can :create, Node
    end
  end
end

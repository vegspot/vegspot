class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Anyone
    can :read, :all

    # Admin user
    if user.is_admin?
      can :manage, :all
    end

    # Regular logged in user
    if user.persisted?
      can :create, Comment
      can :create, Node
    end
  end
end

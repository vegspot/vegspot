class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # if user.admin?
    #   can :manage, :all
    # else
    #   can :read, :all
    # end

    # Anyone
    can :read, :all

    # Regular logged in user
    if user
      can :create, Comment
      can :manage, Node, user_id: user.id
    end
  end
end

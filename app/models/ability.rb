class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
      can :update, User, user_id: user.id
    end
  end
end

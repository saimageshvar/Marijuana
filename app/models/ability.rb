class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, Feature
    elsif user.has_role? :developer
      can :read, Feature
    end
  end
end

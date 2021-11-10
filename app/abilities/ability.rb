class Ability
  include CanCan::Ability

  def initialize user
    user ? send(user.role, user) : any
  end

  # role
  def any
    can :read, :all
  end

  def customer user
    any
    can :manage, user: user
  end

  def staff user
    customer user
    can :update, :all
  end

  def admin _user
    can :manage, :all
  end
end

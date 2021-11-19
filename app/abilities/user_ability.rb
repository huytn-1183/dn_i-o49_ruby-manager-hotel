class UserAbility < Ability
  # role

  # override
  # any only create for sign up
  # any cannot read user
  def any
    can :create, User
    cannot :read, User
  end

  # override
  def staff user
    customer user
    can :read, User, role: "customer"
  end
end

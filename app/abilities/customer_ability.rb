class CustomerAbility < Ability
  # role

  # override
  def any
    super
    cannot :read, Booking
    cannot :read, BookingDetail
  end

  # override
  def customer user
    any
    can :create, Booking
    can :create, BookingDetail
    can :read, Booking, user: user
    can :read, BookingDetail, user: user
  end
end

class BookingsController < ApplicationController
  before_action :login_required, :load_bookings, only: %i(index)

  def index; end

  private

  def load_bookings
    @bookings = case current_user.role
                when :admin
                  Booking.all_as_admin prs[:page]
                when :staff
                  Booking.all_as_staff
                else
                  Booking.all_as_customer current_user
                end
    @bookings = @bookings.status_is prs[:status]
    @bookings = @bookings.pagination_at prs[:page]
  end

  # params permit

  def prs
    params.permit(:page, :status, :room_status)
  end
end

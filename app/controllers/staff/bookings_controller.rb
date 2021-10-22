class Staff::BookingsController < ApplicationController
  before_action :load_bookings, only: %i(index)

  def index; end

  # before action

  def load_bookings
    @bookings = Booking.all_as_admin filter_params
    @bookings = @bookings.status_is filter_params[:status]
  end

  # param permit

  def filter_params
    params.permit(:page, :status)
  end
end

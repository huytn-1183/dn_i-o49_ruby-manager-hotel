class Admin::BookingsController < ApplicationController
  before_action :load_bookings, only: %i(index)

  load_and_authorize_resource :booking_details

  def index; end

  private

  # before action

  def load_bookings
    @bookings = Booking.preload(:booking_details)
                       .status_is(filter_params[:status])
                       .pagination_at(filter_params[:page])
    return if @bookings.any?

    flash.now[:warning] = t :empty
  end

  # param permit

  def filter_params
    params.permit(:page, :status)
  end

  # override
  # for custom ability
  def current_ability
    @current_ability = CustomerAbility.new(current_user)
  end
end

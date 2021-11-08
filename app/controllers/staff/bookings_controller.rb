class Staff::BookingsController < ApplicationController
  before_action :load_bookings, only: %i(index)
  before_action :load_booking, only: %i(update)

  def update
    @booking.update! booking_params
    redirect_to admin_bookings_path session[:filter_params]
  end

  rescue_from ArgumentError do
    flash[:warning] = t :warning
  end

  def index; end

  private

  # before action

  def load_bookings
    @bookings = Booking.preload(:booking_details)
                       .status_is(filter_params[:status])
                       .pagination_at(filter_params[:page])
    return if @bookings.any?

    flash[:warning] = t :empty
  end

  def load_booking
    @booking = Booking.find params[:id]
    return if @booking
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = t :not_found
  end

  # param permit

  def filter_params
    # permit and remember filter_params
    session[:filter_params] = params.permit(:page, :status, :user_name)
  end

  def booking_params
    raw_params = params.require(:booking).permit(:status)
    raw_params[:status] = params[:booking][:status].to_i
    raw_params
  end
end

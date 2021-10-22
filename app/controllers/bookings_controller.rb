class BookingsController < ApplicationController
  before_action :logged_in_user, :check_session_room_id, only: :create

  def create
    @booking = current_user.bookings.build
    if Booking.create_booking @booking, params[:room_id],
                              checkin_param, checkout_param
      flash[:success] = t "controllers.bookings_controller.booking_successfull"
      redirect_to root_path
    else
      flash[:warning] = t "controllers.bookings_controller.booking_fail"
      redirect_to confirm_path
    end
    byebug
  end

  def checkin_param
    session[params[:room_id]]["date_in"]
  end

  def checkout_param
    session[params[:room_id]]["date_out"]
  end

  def check_session_room_id
    return if session.keys.include? params[:room_id]

    flash[:danger] = t :not_found
    redirect_to root_path
  end
end

class BookingsController < ApplicationController
  before_action :load_bookings, only: %i(index)

  def index; end

  private

  # before action

  def load_bookings
    @bookings = current_user.bookings
                            .status_is(filter_params[:status])
                            .pagination_at filter_params[:page]
    return if @bookings.any?

    flash.now[:warning] = t :empty
  end

  # param permit

  def filter_params
    params.permit(:page, :status)
  end
end

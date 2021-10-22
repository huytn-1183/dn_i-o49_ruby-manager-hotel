class BookingDetailsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @result = Room.where(id: session.keys)
    abc = BookingDetail.joins(:room).where(room_id: session.keys)
    byebug
    # bd = BookingDetails.joins(@result)
    # @day = session[@result[1].id][:date_in]
  end
end

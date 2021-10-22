class BookingDetailsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @result = Room.where(id: session.keys)
  end

  def update; end
end

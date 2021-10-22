class Staff::RoomsController < ApplicationController
  before_action :load_rooms, only: %i(index)
  before_action :load_room, only: %i(update)

  def index; end

  def update
    @room.available!
    flash[:success] = t :success
    redirect_to staff_rooms_path
  end

  private

  def load_rooms
    @rooms = Room.unavailable.pagination_at(filter_params[:page])
    return if @rooms.any?

    flash.now[:danger] = t :empty
  end

  def load_room
    @room = Room.find params[:id]
    return if @room

    flash.now[:warning] = t :not_found
  end

  # params permit

  def filter_params
    params.permit(:page)
  end
end

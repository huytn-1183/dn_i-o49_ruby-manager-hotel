class RoomsController < ApplicationController
  before_action :load_rooms, except: %i(show)
  before_action :load_room, only: %i(show confirm)
  before_action :load_attributes

  def index; end

  def show; end

  def confirm
    room_id = params[:id]
    @added = session[room_id]
  end

  private

  # before action

  def load_attributes
    @attributes = RoomAttribute.pluck(:name, :id)
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room

    flash[:danger] = t :not_found
    redirect_to root_path
  end

  def load_rooms
    attrs = filter_params[:attributes] || []
    @rooms = Room.available
                 .price_sort(filter_params[:sort])
                 .name_search(filter_params[:keyword])
                 .pagination_at(filter_params[:page])

    @rooms = @rooms.has_attributes attrs if attrs.length > 1
    return if @rooms.any?

    flash.now[:danger] = t :empty
  end

  # params permit

  def filter_params
    params.permit(:id, :sort, :keyword, :page, :locale, attributes: [])
  end
end

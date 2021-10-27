class RoomsController < ApplicationController
  before_action :load_rooms, only: %i(index)
  before_action :load_room, only: %i(show)
  before_action :load_attributes

  # routes

  def index; end

  def show; end

  private

  # before action

  def load_attributes
    @attributes = RoomAttribute.pluck(:name, :id)
  end

  def load_room
    @room = Room.find_by id: prs[:id]
    return if @room

    flash[:danger] = t :not_found
    redirect_to root_path
  end

  def load_rooms
    attrs = prs[:attributes] || []
    @rooms = Room.all_as_any
    @rooms = @rooms.has_attributes attrs if attrs.length > 1
    @rooms = @rooms.price_sort prs[:sort]
    @rooms = @rooms.name_search prs[:keyword]
    @rooms = @rooms.pagination_at prs[:page]
    flash.now[:danger] = t :empty_result unless @rooms.any?
  end

  # params permit

  def prs
    params.permit(:id, :sort, :keyword, :page, :locale, attributes: [])
  end
end

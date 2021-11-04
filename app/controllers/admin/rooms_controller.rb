class Admin::RoomsController < ApplicationController
  before_action :load_rooms, only: %i(index)

  def export
    rooms = Room.select(:id, :name, :price)
    respond_to do |format|
      format.html
      format.csv do
        send_data rooms.to_csv(%w(id name price)),
                  filename: format(
                    "%{name}%{time}.csv",
                    time: Date.new.to_s,
                    name: Settings.export.room.name
                  )
      end
    end
  end

  def import
    Room.import file_params
    flash[:success] = t :success
    redirect_to admin_rooms_path
  end

  rescue_from ActiveRecord::RecordInvalid do
    flash[:danger] = t :in_valid
    redirect_to admin_rooms_path
  end

  def index; end

  private

  # before action

  def load_rooms
    @rooms = Room.pagination_at(filter_params[:page])
    return if @rooms.any?

    flash.now[:danger] = t :empty
  end

  # params permit

  def file_params
    params.require(:file)
  end

  def filter_params
    params.permit(:page)
  end

  rescue_from ActionController::ParameterMissing do |_e|
    flash[:danger] = t :missing
    redirect_to admin_rooms_path
  end

  rescue_from CSV::MalformedCSVError do |_e|
    flash[:danger] = t :in_valid
    redirect_to admin_rooms_path
  end
end

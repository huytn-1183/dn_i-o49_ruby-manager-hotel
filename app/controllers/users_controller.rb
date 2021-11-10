class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t :not_found
    redirect_to new_user_session_path
  end
end

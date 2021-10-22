class UsersController < ApplicationController
  before_action :logged_in_user, only: :show

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "controllers.users_controller.user_not_found"
    redirect_to new_user_path
  end
end

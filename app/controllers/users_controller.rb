class UsersController < ApplicationController
  before_action :load_user, only: %i(show)
  before_action :load_users, only: %i(index)

  def index; end

  def show; end

  # before_action

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t :not_found
    redirect_to new_user_session_path
  end

  def load_users
    @users = User.latest.pagination_at(params[:page])
    return if @users.any?

    flash[:danger] = t :empty
    redirect_to root_path
  end

  # override
  # for custom ability
  def current_ability
    @current_ability = UserAbility.new(current_user)
  end
end

class SessionsController < ApplicationController
  before_action :current_user
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      actived_user user
    else
      flash.now[:danger] = t "controllers.sessions_controller.invalid_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def actived_user user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to session[:return_to] || root_url
  end
end

class SessionsController < ApplicationController
  before_action :logged_in_user, :check_date_blank, :check_date_current,
                only: :update

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      actived_user user
    else
      flash.now[:danger] = t(:invalid_login)
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
    redirect_back_or user
  end

  def update
    session[params[:room_id]] =
      {date_in: params[:date_in], date_out: params[:date_out]}
    redirect_to confirm_path(id: params[:room_id])
  end

  def check_date_blank
    return unless checkin_param.blank? || checkout_param.blank?

    flash[:danger] = t(:not_blank)
    redirect_to room_path(params[:room_id])
  end

  def check_date_current
    return if checkout_param > checkin_param &&
              checkin_param >= DateTime.current.to_date

    flash[:danger] = t(:checkin)
    redirect_to room_path(params[:room_id])
  end

  def checkin_param
    params[:date_in].to_date if params[:date_in].present?
  end

  def checkout_param
    params[:date_out].to_date if params[:date_out].present?
  end
end

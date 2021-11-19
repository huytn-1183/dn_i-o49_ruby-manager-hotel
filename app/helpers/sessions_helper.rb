module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def is_admin?
    current_user.admin?
  end

  def namespace_bookings_path
    return admin_bookings_path if is_admin?

    bookings_path
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    return unless user

    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end

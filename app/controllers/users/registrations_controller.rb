# Registration frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    super
  end

  # PUT /resource
  def update
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :name, :gender])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:phone, :name, :gender]
    )
  end

  def after_inactive_sign_up_path_for resource
    super(resource)
    new_user_registration_path
  end

  def after_update_path_for resource
    super(resource)
    edit_user_registration_path
  end
end

class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception

  include SessionsHelper

  load_and_authorize_resource unless: :devise_controller?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json{head :forbidden}
      format.html{redirect_to root_path, alert: t(:access_denied)}
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :user_admin?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  private

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def extract_locale_from_accept_language_header
    locales = I18n.available_locales.map(&:to_s)
    lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']

    if locales.include?(lang)
      lang
    else
      I18n.default_locale
    end
  end

  def after_sign_in_path_for(_user)
    admin_dashboard_path
  end

  def user_admin?
    current_user.try(:admin?)
  end
end

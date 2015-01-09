class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to admin_error_path, alert: 'You are not an admin!'
    end
  end

  def after_sign_in_path_for(user)
    admin_dashboard_path
  end
end

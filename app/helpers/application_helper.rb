module ApplicationHelper
  def current_path(path)
    current_route = Rails.application.routes.recognize_path(path)
    'active-menu' if current_page?(path) || params[:controller] == current_route[:controller]
  end
end

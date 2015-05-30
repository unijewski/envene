module ApplicationHelper
  def current_path(path)
    current_route = Rails.application.routes.recognize_path(path)
    destination = params[:controller].split('/').last.split('_').first.pluralize
    if current_page?(path) ||
       params[:controller] == current_route[:controller] ||
       current_route[:controller].include?(destination)
      'active-menu'
    end
  end
end

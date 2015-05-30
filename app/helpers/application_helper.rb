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

  def page_header
    params[:controller].split('/').last.humanize
  end

  def page_header_singularized
    page_header.singularize
  end
end

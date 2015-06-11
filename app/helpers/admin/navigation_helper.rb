module Admin
  module NavigationHelper
    def current_path(path)
      current_route = Rails.application.routes.recognize_path(path)
      destination = params[:controller].split('/').last.split('_').first.pluralize
      return unless current_page?(path) ||
                    params[:controller] == current_route[:controller] ||
                    current_route[:controller].include?(destination)
      'active-menu'
    end

    def change_locale_path(locale)
      path = request.env['PATH_INFO'][3..-1]
      path.prepend('/' + locale)
    end
  end
end

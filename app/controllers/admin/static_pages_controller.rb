module Admin
  class StaticPagesController < Admin::AdminController
    before_action :authenticate_admin, except: [:error]

    def index
    end

    def error
    end
  end
end

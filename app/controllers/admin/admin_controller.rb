module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin

    private

    def authenticate_admin
      redirect_to admin_error_path, alert: t('not_admin') unless user_admin?
    end
  end
end

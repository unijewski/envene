class Admin::AdminController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless user_admin?
      redirect_to admin_error_path, alert: t('not_admin')
    end
  end
end

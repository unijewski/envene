class Admin::AdminController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless user_admin?
      redirect_to admin_error_path, alert: 'You are not an admin!'
    end
  end

  def user_admin?
    current_user.admin?
  end
end

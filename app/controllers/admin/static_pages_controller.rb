class Admin::StaticPagesController < ApplicationController
  before_action :check_admin, except: [:error]

  def index
  end

  def error
  end
end

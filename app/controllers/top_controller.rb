class TopController < ApplicationController
  before_action :admin_logged_in?

  def admin_logged_in?
    if current_admin.present?
      redirect_to customers_path
    else
      redirect_to admin_session_path
    end
  end

  def index
  end
end

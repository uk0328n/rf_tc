class TopController < ApplicationController
  before_action :admin_logged_in?

  def admin_logged_in?
    if current_admin.present?
      if current_admin.role_type <= 2
        redirect_to customers_path
      else
        redirect_to pages_index_path
      end
    else
      redirect_to new_admin_session_path
    end
  end

  def index
  end
end

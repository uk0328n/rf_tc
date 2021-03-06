class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_admin
  before_action :admin_logged_in?

  def set_current_admin
    Thread.current[:admin] = current_admin
  end

  def admin_logged_in?
    unless current_admin.present?
      unless request.path == '/admins/sign_in'
        redirect_to new_admin_session_path
      end
    end
  end

  protected

  def configure_permitted_parameters
    #strong parametersを設定し、usernameとemailを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

end

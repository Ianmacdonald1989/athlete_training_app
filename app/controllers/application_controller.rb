class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :require_login

  helper_method :current_user

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = session[:user_id] && User.find_by(id: session[:user_id])
  end

  def require_login
    return if current_user

    redirect_to new_session_path, alert: "Please sign in to continue."
  end
end

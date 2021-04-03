class ApplicationController < ActionController::Base
  helper_method :current_user

  private
  def authenticate_user_registration!
    unless current_user
      redirect_to signup_path
    end
  end

  def current_user
    @current_user ||= session[:auth_token] &&
      User::Registration.find_by(auth_token: session[:auth_token])
  end

  def require_unauthenticated
    if current_user
      redirect_to user_dashboard_path
    else
      true
    end
  end

  def redirect_to_safe_landing
    if current_user
      redirect_to user_dashboard_path
    else
      redirect_to signin_path
    end
  end
end

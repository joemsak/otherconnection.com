class ApplicationController < ActionController::Base
  helper_method :current_user

  private
  def authenticate_user_registration!
    unless current_user
      redirect_to signup_path
    end
  end

  def current_user
    @current_user ||= User::Registration.find_by(auth_token: session[:auth_token])
  end
end

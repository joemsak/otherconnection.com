class User::SessionsController < ApplicationController
  layout "focused"

  def new
    if valid_auth_token
      session[:auth_token] = valid_auth_token
      redirect_to user_dashboard_path
    end
  end

  def create
    @registration = User::Registration.find_by(email: params[:email])
    @registration.regenerate_session_token
    User::SessionMailer.signin(@registration).deliver_later
    redirect_to @registration
  end

  def destroy
    session[:auth_token] = nil
    @current_user = nil
    redirect_to root_path
  end

  private
  def valid_auth_token
    @valid_auth_token ||= params[:token] &&
      User::Registration.auth_token(session_token: params[:token])
  end
end

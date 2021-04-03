class User::SessionsController < ApplicationController
  layout "focused"

  before_action :require_unauthenticated

  skip_before_action :verify_authenticity_token, only: :create

  def new
    if valid_auth_token
      session[:auth_token] = valid_auth_token
      redirect_to user_dashboard_path
    end
  end

  def create
    if auth_hash && !current_user
      registration = User::Registration.find_or_create_by_auth(auth_hash)
      session[:auth_token] = registration.auth_token
      redirect_to user_dashboard_path
    elsif auth_hash
      current_user.find_or_create_authentication(auth_hash)
      redirect_to user_dashboard_path
    elsif valid_auth_token
      session[:auth_token] = valid_auth_token
      redirect_to user_dashboard_path
    else
      registration = User::Registration.find_by(email: params[:email])
      registration.regenerate_session_token
      User::SessionMailer.signin(registration).deliver_later
      redirect_to registration
    end
  end

  def destroy
    session[:auth_token] = nil
    @current_user = nil
    redirect_to user_dashboard_path
  end

  private
  def valid_auth_token
    @valid_auth_token ||= params[:token] &&
      User::Registration.auth_token(session_token: params[:token])
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end

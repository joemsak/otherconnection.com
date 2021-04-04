class User::SessionsController < ApplicationController
  layout "focused"

  before_action :require_unauthenticated, except: :destroy

  skip_before_action :verify_authenticity_token, only: :create

  def new
    if valid_auth_token
      sign_user_in
    elsif invalid_signin?
      render_invalid_error
    end
  end

  def create
    if unauthenticated_oauth_callback?
      signin_from_oauth
    elsif authenticated_oauth_callback?
      connect_oauth_to_current_user
    elsif valid_auth_token
      sign_user_in
    elsif valid_signin_details?
      send_magic_signin_link
    else
      render_invalid_error
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

  def unauthenticated_oauth_callback?
    auth_hash && !current_user
  end

  def authenticated_oauth_callback?
    auth_hash && current_user
  end

  def valid_signin_details?
    @registration = User::Registration.find_by(email: params[:email])
    @registration.present?
  end

  def invalid_signin?
    params[:email].present? && !valid_signin_details?
  end

  def signin_from_oauth
    registration = User::Registration.find_or_create_by_auth(auth_hash)
    session[:auth_token] = registration.auth_token
    redirect_to user_dashboard_path
  end

  def connect_oauth_to_current_user
    current_user.find_or_create_authentication(auth_hash)
    redirect_to user_dashboard_path
  end

  def sign_user_in
    session[:auth_token] = valid_auth_token
    redirect_to user_dashboard_path
  end

  def send_magic_signin_link
    @registration.regenerate_session_token
    User::SessionMailer.signin(@registration).deliver_later
    redirect_to @registration
  end

  def render_invalid_error
    flash.now.notice = t(".invalid_credentials")
    render :new, status: :unprocessable_entity
  end
end

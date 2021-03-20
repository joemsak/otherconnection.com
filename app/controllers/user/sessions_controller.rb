class User::SessionsController < ApplicationController
  def new
    if valid_auth_token
      session[:auth_token] = valid_auth_token
      redirect_to user_dashboard_path
    end
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

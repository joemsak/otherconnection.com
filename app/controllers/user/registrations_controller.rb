class User::RegistrationsController < ApplicationController
  before_action :load_new_registation

  def create
    @registration.save
    User::RegistrationsMailer.signup(@registration).deliver_later
    redirect_to @registration
  end

  private
  def load_new_registation
    if params[:user_registration]
      @registration = User::Registration.new(user_registration_params)
    else
      @registration = User::Registration.new
    end
  end

  def user_registration_params
    params.require(:user_registration).permit(:name, :email)
  end
end

class User::RegistrationsController < ApplicationController
  layout "focused"

  before_action :load_new_registation

  def create
    @registration.update(user_registration_params)
    User::RegistrationsMailer.signup(@registration).deliver_later
    redirect_to @registration
  end

  private
  def load_new_registation
    if action_name == "create"
      @registration = User::Registration.find_or_initialize_by(
        email: user_registration_params[:email]
      )
    else
      @registration = User::Registration.new
    end
  end

  def user_registration_params
    params.require(:user_registration).permit(:name, :email)
  end
end

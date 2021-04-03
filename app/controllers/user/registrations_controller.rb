class User::RegistrationsController < ApplicationController
  layout "focused"

  before_action :load_new_registation,
    :require_unauthenticated

  def create
    mailer = User::RegistrationsMailer
    mail = :signup

    if @registration.persisted?
      mailer = User::SessionMailer
      mail = :signin
    end

    @registration.update(user_registration_params)
    mailer.send(mail, @registration).deliver_later

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
    params.require(:user_registration)
      .permit(:name, :email)
      .reject { |k, v| v.blank? }
  end
end

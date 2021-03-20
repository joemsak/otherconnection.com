class User::RegistrationsMailer < ApplicationMailer
  def signup(registration)
    @registration = registration
    mail to: @registration.email
  end
end

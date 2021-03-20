class User::SessionMailer < ApplicationMailer

  #   en.user.session_mailer.signin.subject
  def signin(registration)
    @registration = registration
    mail to: registration.email
  end
end

class User::RegistrationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user.registrations_mailer.signup.subject
  #
  def signup(registration)
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

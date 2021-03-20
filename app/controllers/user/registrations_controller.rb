class User::RegistrationsController < ApplicationController
  before_action :load_new_registation

  def create
    @registration.save
    User::RegistrationsMailer.signup(@registration).deliver_later
    redirect_to @registration
  end

  private
  def load_new_registation
    @registration = User::Registration.new
  end
end

class User::RegistrationsController < ApplicationController
  before_action :load_new_registation

  private
  def load_new_registation
    @registration = User::Registration.new
  end
end

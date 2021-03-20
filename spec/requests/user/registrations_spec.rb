require 'rails_helper'

RSpec.describe "Users::Registrations" do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "sends a signup email" do
      expect {
        post user_registrations_path
      }.to have_enqueued_mail(User::RegistrationsMailer, :signup)
    end

    it "redirects to the registration" do
      post user_registrations_path
      registration = User::Registration.last
      expect(response).to redirect_to(user_registration_path(registration))
    end
  end
end

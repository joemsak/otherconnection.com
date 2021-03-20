require 'rails_helper'

RSpec.describe "Users::Registrations" do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      { user_registration: attributes_for(:user_registration) }
    end

    it "sends a signup email" do
      expect {
        post user_registrations_path, params: valid_params
      }.to have_enqueued_mail(User::RegistrationsMailer, :signup)
    end

    it "redirects to the registration" do
      post user_registrations_path, params: valid_params
      registration = User::Registration.last
      expect(response).to redirect_to(user_registration_path(registration))
    end

    context "with duplicate email" do
      let(:email) { "joe@joesak.com" }

      let!(:registration) { create(:user_registration, email: "joe@joesak.com") }

      it "reuses the existing registration" do
        expect {
          post user_registrations_path, params: {
            user_registration: { email: email }
          }
        }.not_to change { User::Registration.count }.from(1)
      end

      it "updates the name on the existing registration" do
        expect {
          post user_registrations_path, params: {
            user_registration: { email: email, name: "This Test" }
          }
        }.to change { registration.reload.name }.to('This Test')
      end
    end
  end
end

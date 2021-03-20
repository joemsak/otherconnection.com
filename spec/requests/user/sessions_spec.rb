require 'rails_helper'

RSpec.describe "User::Sessions", type: :request do
  let(:registration) { create(:user_registration) }

  describe "GET /new" do
    it "returns http success" do
      get signin_path
      expect(response).to have_http_status(:success)
    end

    context "with a token" do
      it "redirects to the user dashboard" do
        get signin_path(token: registration.session_token)
        expect(response).to redirect_to(user_dashboard_path)
      end
    end
  end

  describe "POST /" do
    it "regenerates the session token" do
      expect {
        post user_session_path, params: { email: registration.email }
      }.to change {
        registration.reload.session_token
      }
    end

    it "sends a login link to their email" do
      expect {
        post user_session_path, params: { email: registration.email }
      }.to have_enqueued_mail(User::SessionMailer, :signin)
    end
  end
end

require 'rails_helper'

RSpec.describe "User::Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get signin_path
      expect(response).to have_http_status(:success)
    end

    context "with a token" do
      let(:registration) { create(:user_registration) }

      it "redirects to the user dashboard" do
        get signin_path(token: registration.session_token)
        expect(response).to redirect_to(user_dashboard_path)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "User::Dashboards", type: :request do
  describe "GET /" do
    let(:registration) { create(:user_registration) }

    before do
      get signin_path(token: registration.session_token)
    end

    it "returns http success" do
      get user_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end

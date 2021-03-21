require 'rails_helper'

RSpec.describe "User::Authentications", type: :request do
  let(:registration) { create(:user_registration) }

  before do
    sign_in(registration)
    create(:user_authentication, provider: :docusign, registration: registration)
  end

  describe "DELETE /:provider" do
    it "returns http success" do
      delete user_authentication_path(:docusign)
      expect(response).to redirect_to(user_dashboard_path)
    end
  end
end

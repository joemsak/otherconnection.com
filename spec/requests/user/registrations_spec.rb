require 'rails_helper'

RSpec.describe "Users::Registrations" do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post user_registrations_path
      expect(response).to have_http_status(:success)
    end

    it "renders the create template" do
      post user_registrations_path
      expect(response).to render_template('user/registrations/create')
    end
  end
end

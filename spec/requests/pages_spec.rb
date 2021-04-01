require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /show" do
    it "returns http success" do
      create(:page, title: "Home")
      get page_path(:home)
      expect(response).to have_http_status(:success)
    end
  end
end

require 'rails_helper'

RSpec.describe User::Authentication, type: :model do
  describe "#email" do
    it "returns the info['email']" do
      auth = create(:user_authentication, info: { email: "joe@joesak.com" })
      expect(auth.email).to eq("joe@joesak.com")
    end
  end
end

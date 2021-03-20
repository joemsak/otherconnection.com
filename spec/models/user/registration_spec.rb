require 'rails_helper'

RSpec.describe User::Registration do
  let(:registration) do
    create(:user_registration, name: "Jack", email: "jack@thehill.com")
  end

  describe "#name" do
    it "has a name" do
      expect {
        registration.update(name: "Jill")
      }.to change {
        registration.name
      }.from("Jack").to("Jill")
    end
  end

  describe "#email" do
    it "has an email" do
      expect {
        registration.update(email: "jill@thehill.com")
      }.to change {
        registration.email
      }.from("jack@thehill.com").to("jill@thehill.com")
    end
  end

  describe "#session_token" do
    it "has_secure_token :session_token, length: 36" do
      expect(registration.session_token).not_to be_nil
      expect(registration.session_token.length).to be 36
    end
  end

  describe "#auth_token" do
    it "has_secure_token :auth_token, length: 36" do
      expect(registration.auth_token).not_to be_nil
      expect(registration.auth_token.length).to be 36
    end
  end

  describe ".auth_token" do
    it "finds the auth token from secure search options" do
      expect(described_class.auth_token(name: registration.name)).to be_nil
      expect(described_class.auth_token(email: registration.email)).to be_nil
      expect(described_class.auth_token(session_token: registration.session_token)).to eq(
        registration.auth_token
      )
    end
  end
end

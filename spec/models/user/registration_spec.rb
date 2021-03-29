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

  describe "#oauth_email" do
    it "delegates to the authentication's info email by provider name" do
      create(
        :user_authentication,
        registration: registration,
        email: "test@test.com",
        provider: :test
      )

      expect(registration.oauth_email(:test)).to eq("test@test.com")
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

  describe "#authentication_exists?" do
    before do
      create(:user_authentication, registration: registration, provider: "example")
    end

    it "returns true for authentications by provider name" do
      expect(registration).to be_authentication_exists("example")
    end

    it "returns false for unfound authentications" do
      expect(registration).not_to be_authentication_exists("foo")
    end
  end
end

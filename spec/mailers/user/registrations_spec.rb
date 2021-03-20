require "rails_helper"

RSpec.describe User::RegistrationsMailer, type: :mailer do
  describe "signup" do
    let(:registration) { create(:user_registration, email: "joe@joesak.com") }
    let(:mail) { User::RegistrationsMailer.signup(registration) }

    it "renders the headers" do
      expect(mail.subject).to eq("Signup")
      expect(mail.to).to eq(["joe@joesak.com"])
      expect(mail.from).to eq(["coach@theotherconnection.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

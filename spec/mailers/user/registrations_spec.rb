require "rails_helper"

RSpec.describe User::RegistrationsMailer, type: :mailer do
  describe "signup" do
    let(:registration) { create(:user_registration, email: "joe@joesak.com") }
    let(:mail) { User::RegistrationsMailer.signup(registration) }

    it "renders the headers" do
      expect(mail.subject).to eq("Thank you for signing up! Login with this email.")
      expect(mail.to).to eq(["joe@joesak.com"])
      expect(mail.from).to eq(["coach@theotherconnection.com"])
    end

    it "renders the magic login link" do
      expect(mail.body.encoded).to have_link(
        "Log in now",
        href: signin_url(token: registration.session_token)
      )
    end
  end
end

require "rails_helper"

RSpec.describe User::SessionMailer, type: :mailer do
  describe "signin" do
    let(:registration) { create(:user_registration) }

    let(:mail) { User::SessionMailer.signin(registration) }

    it "renders the headers" do
      expect(mail.subject).to eq("Here is your login link")
      expect(mail.to).to eq([registration.email])
    end

    it "renders the login link" do
      expect(mail.body.encoded).to have_link(
        "Log in now",
        href: signin_url(token: registration.session_token)
      )
    end
  end

end

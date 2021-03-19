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
end

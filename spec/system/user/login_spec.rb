require "rails_helper"

RSpec.describe "Logging in", :js do
  scenario "From the home page" do
    registration = create(:user_registration)

    visit root_path

    click_on "Log in"

    fill_in "Email", with: registration.email

    click_on "Log in"

    expect(page).to have_content(successful_login_message)
  end
end

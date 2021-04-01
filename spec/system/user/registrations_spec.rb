require "rails_helper"

RSpec.describe "Register a new user", :js do
  scenario "Sign up with name & email" do
    visit signup_path

    fill_in 'Name', with: "Joe Sak"
    fill_in 'Email', with: "joe@joesak.com"

    click_on "Sign up"

    expect(page).to have_content(succcessful_signup_message)
  end
end

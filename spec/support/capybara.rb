require 'capybara/rails'
require 'webdrivers'

chrome_bin = ENV['GOOGLE_CHROME_SHIM'] if ENV['GOOGLE_CHROME_SHIM'].present?

chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  chromeOptions: {
    args: %w[headless disable-gpu window-size=1400x1400],
    binary: chrome_bin
  }
)

Capybara.register_driver :heroku_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: chrome_capabilities
  )
end

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV["HEROKU_CI"]
      driven_by :heroku_chrome
    else
      driven_by :chrome_headless
    end
  end
end


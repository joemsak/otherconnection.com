module ContentHelper
  def succcessful_signup_message
    "Check your email for your login link"
  end

  def successful_login_message
    succcessful_signup_message
  end
end

RSpec.configure do |config|
  config.include ContentHelper
end

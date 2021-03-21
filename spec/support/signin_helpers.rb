module SigninHelpers
  module Request
    def sign_in(registration)
      post user_session_path, params: { token: registration.session_token }
    end
  end
end

RSpec.configure do |config|
  config.include SigninHelpers::Request, type: :request
end

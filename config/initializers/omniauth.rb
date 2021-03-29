# frozen_string_literal: true

require 'docusign'

OmniAuth.config.logger = Rails.logger

# OmniAuth.config.failure_raise_out_environments = [] # defaults to: ['development']

OmniAuth.config.allowed_request_methods = [:post, :get]

config = Rails.application.config
credentials = Rails.application.credentials

config.middleware.use OmniAuth::Builder do
  provider :calendly, credentials.calendly[:client_id], credentials.calendly[:client_secret]

  provider :docusign, config.integration_key, config.integration_secret, setup: lambda { |env|
    strategy = env['omniauth.strategy']

    strategy.options[:client_options].site = config.app_url

    strategy.options[:prompt] = 'login'

    strategy.options[:oauth_base_uri] = config.authorization_server

    strategy.options[:target_account_id] = config.target_account_id

    strategy.options[:allow_silent_authentication] = config.allow_silent_authentication

    strategy.options[:client_options].authorize_url = "#{strategy.options[:oauth_base_uri]}/oauth/auth"
    strategy.options[:client_options].user_info_url = "#{strategy.options[:oauth_base_uri]}/oauth/userinfo"
    strategy.options[:client_options].token_url = "#{strategy.options[:oauth_base_uri]}/oauth/token"

    unless strategy.options[:allow_silent_authentication]
      strategy.options[:authorize_params].prompt = strategy.options.prompt
    end

    if Rails.configuration.examples_API['Rooms'] == true
      strategy.options[:authorize_params].scope = "signature dtr.rooms.read dtr.rooms.write dtr.documents.read dtr.documents.write dtr.profile.read dtr.profile.write dtr.company.read dtr.company.write room_forms"
    elsif Rails.configuration.examples_API['Click'] == true
      strategy.options[:authorize_params].scope = "signature click.manage click.send"
    end
  }
end

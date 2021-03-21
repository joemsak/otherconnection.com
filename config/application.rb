require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    DOCUSIGN_CONFIG = YAML.load(
      ERB.new(File.read(Rails.root.join("config", "docusign.yml"))).result
    )[Rails.env]

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.i18n.load_path += Dir[
      Rails.root.join('config', 'locales', '**', '*.{rb,yml}')
    ]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_job.queue_name_prefix = "app_#{Rails.env}"
    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.default_url_options = {
      host: ENV["APP_HOST"],
      port: ENV["APP_PORT"]
    }

    config.generators do |g|
      g.test_framework :rspec
      g.helper_specs false
      g.controller_specs false
      g.view_specs false
      g.routing_specs false
      g.fixture_replacement :factory_bot, dir: "spec/factories"

      g.stylesheets false
      g.helper false

      g.orm :active_record, primary_key_type: :uuid
    end

    config.app_url = ENV["APP_HOST"]

    DOCUSIGN_CONFIG.each { |k, v| config.send("#{k}=", v) }
  end
end

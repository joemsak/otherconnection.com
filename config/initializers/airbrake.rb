unless Rails.env.test?
  require 'airbrake-ruby'

  Airbrake.configure do |c|
    c.project_id = Rails.application.credentials.airbrake[:project_id]
    c.project_key = Rails.application.credentials.airbrake[:project_key]
  end
end

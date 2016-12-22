require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Triglav
  class Application < Rails::Application
    require_relative '../app/models/settings' # settingslogic

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.time_zone = Settings.rails.time_zone

    config.autoload_paths += %W( #{config.root}/app/policies
                                 #{config.root}/app/services )
    config.eager_load_paths += %W( #{config.root}/lib/ )

    require_relative '../lib/triglav/logger'
    require_relative '../lib/triglav/rack/access_logger'

    # logger
    $access_logger = Triglav::Logger.new(Settings.access_log_path, Settings.log_shift_age, Settings.log_shift_size)
    config.middleware.insert_after(0, Triglav::Rack::AccessLogger, $access_logger)

    rails_log_path  = Settings.webapp_log_path
    rails_log_level = Settings.webapp_log_level

    config.logger = Triglav::Logger.new(rails_log_path, Settings.log_shift_age, Settings.log_shift_size)
    config.log_level = rails_log_level
  end
end

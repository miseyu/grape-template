require File.expand_path('../boot', __FILE__)

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

module GrapeTemplate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join("lib")
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
      end
    end

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_types = [:datetime, :time]

    config.encoding = "utf-8"

    config.action_controller.include_all_helpers = false

    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.test_framework  :rspec, :fixture => true
      g.integration_tool :rspec
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.factory_girl dir: 'spec/factories'
      g.view_specs false
      g.controller_specs true
      g.helper_specs false
      g.routing_specs false
      g.request_specs false
    end
  end
end

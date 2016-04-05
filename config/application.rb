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

require_relative '../lib/access_token.rb'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UsersApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.autoload_paths += %W(#{config.root}/lib)

    if ENV['RAILS_LOG_TO_STDOUT'].present?
      config.logger = Logger.new STDOUT
    end

    config.middleware.use Rack::OAuth2::Server::Resource::Bearer do |req|
      access_token = AccessToken.from req.access_token
      req.invalid_token! unless access_token.active?
      access_token
    end
  end
end

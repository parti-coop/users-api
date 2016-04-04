# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.routes.default_url_options[:host] =
  "#{ENV['USERS_API_EXTERNAL_HOST']}:#{ENV['USERS_API_EXTERNAL_PORT']}"

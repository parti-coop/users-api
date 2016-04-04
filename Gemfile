source 'https://rubygems.org'

gem 'active_model_serializers', '~> 0.10.0.rc4'

gem 'database_cleaner'

gem 'devise', '~> 4.0.0.rc2'
gem 'devise_token_auth', github:"lynndylanhurley/devise_token_auth", branch: "master"

gem 'factory_girl_rails'

gem 'faraday'

gem 'health_check'

gem 'pg'

# Use Puma as the app server
gem 'puma'

gem 'rack-oauth2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'email_spec'
  gem 'json_spec', '~> 1.1.4'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec', '~> 3.5.0.beta2'
  gem 'rspec-rails', '~> 3.5.0.beta2'
  gem 'timecop'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

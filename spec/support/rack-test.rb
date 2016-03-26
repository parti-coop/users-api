module UsersApi::RackTest
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

RSpec.configure do |config|
  config.include UsersApi::RackTest
end

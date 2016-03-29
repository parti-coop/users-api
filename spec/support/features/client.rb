module Features
  module Client
    def users_api_test_client
      ENV['USERS_API_TEST_CLIENT_ID'] or raise 'Missing USERS_API_TEST_CLIENT_ID'
      ENV['USERS_API_TEST_CLIENT_SECRET'] or raise 'Missing USERS_API_TEST_CLIENT_SECRET'
      {
        client_id: ENV['USERS_API_TEST_CLIENT_ID'],
        client_secret: ENV['USERS_API_TEST_CLIENT_SECRET']
      }
    end

    def client_exists
      users_api_test_client
    end
  end
end

module Features
  module UserToken
    include Features::Response
    def user_token_exists(user)
      user.create_new_auth_token
    end

    def verify_user_token(token: nil, user_token:)
      header 'Authorization', "Bearer #{token}" if token

      header 'access-token', user_token['access-token']
      header 'client', user_token['client']
      header 'uid', user_token['uid']

      get v1_users_validate_token_path
    end

    def verify_token_success_should_be_rendered(user:)
      response_should_be_200_ok_json
      token_response = JSON.parse(last_response.body)
      expect(token_response['success']).to be true
      expect(token_response['data']['identifier']).to eq(user.identifier)
    end

    def verify_token_failure_should_be_rendered
      response_should_be_401_unauthorized
      token_response = JSON.parse(last_response.body)
      expect(token_response['success']).to be false
    end
  end
end

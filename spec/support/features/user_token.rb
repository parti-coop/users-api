module Features
  module UserToken
    include Features::Response

    def user_token_exists(user)
      user.create_new_auth_token
    end

    def valid_user_token_exists(user:)
      sign_in_as user
      user_token_in_response(last_response)
    end

    def user_token_should_be_valid(email:, user_token:)
      expect(user_token[:uid]).to eq(email)
      user = ::User.find_by_email(email)
      expect(user.valid_token? user_token[:access_token], user_token[:client]).to be true
    end

    def user_token_should_not_be_valid(email:, user_token:)
      expect(user_token[:uid]).to eq(email)
      user = ::User.find_by_email(email)
      expect(user.valid_token? user_token[:access_token], user_token[:client]).to be false
    end

    def user_token_in_response_should_be_valid(email:)
      token, client, uid = user_token_in_response(last_response).values_at :access_token, :client, :uid
      expect(uid).to eq(email)
      user = ::User.find_by_email(email)
      user.valid_token? token, client
    end

    def user_token_in_response(response)
      response.headers.slice('access-token', 'client', 'uid').transform_keys do |key|
        key.parameterize.underscore.to_sym
      end
    end

    def user_token_in_response_is_empty
      expect(user_token_in_response(last_response)).to be_empty
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

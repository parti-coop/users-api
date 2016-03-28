module Features
  module SignIn
    include Response

    def sign_in(token: nil, **params)
      if token
        header 'Authorization', "Bearer #{token}"
      end
      post v1_user_session_path, params
    end

    def user_token_should_be_valid(email:, token:)
      expect(token[:uid]).to eq(email)
      user = ::User.find_by_email(email)
      expect(user.valid_token? token[:access_token], token[:client]).to be true
    end

    def user_token_should_not_be_valid(email:, token:)
      expect(token[:uid]).to eq(email)
      user = ::User.find_by_email(email)
      expect(user.valid_token? token[:access_token], token[:client]).to be false
    end

    def user_token_in_response_should_be_valid(email:)
      token, client, uid = user_token_in_response(last_response).values_at :access_token, :client, :uid
      expect(uid).to eq(email)
      user = ::User.find_by_email(email)
      user.valid_token? token, client
    end

    def user_token_in_response(response)
      response.headers.slice('access-token', 'client', 'uid').with_indifferent_access
    end

    def user_token_in_response_is_empty
      expect(user_token_in_response(last_response)).to be_empty
    end
  end
end

module Features
  module SignIn
    include Response

    def sign_in(token: nil, **params)
      if token
        header 'Authorization', "Bearer #{token}"
      end
      post v1_user_session_path, params
    end

    def sign_in_as(user)
      token = token_is_granted_by_client_credentials users_api_test_client
      ::User.class_eval do
        alias_method :orig_valid_password?, :valid_password?

        def valid_password?(password)
          encrypted_password == password
        end
      end
      begin
        sign_in(
          email: user.email,
          password: user.encrypted_password,
          token: token[:access_token]
        )
      ensure
        ::User.class_eval do
          alias_method :valid_password?, :orig_valid_password?
          remove_method :orig_valid_password?
        end
      end
    end
  end
end

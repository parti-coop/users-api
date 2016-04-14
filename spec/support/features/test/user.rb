module Features
  module Test
    module User
      def create_users_for_test(token: nil, users: {})
        add_token_header(token)
        post v1_test_users_path, { users: users },
          'Content-Type' => 'application/json'
      end

      def delete_user_for_test(token: nil, user_id:)
        add_token_header(token)
        delete v1_test_user_path(user_id)
      end

      def list_users_for_test(token: nil, **attrs)
        add_token_header(token)
        get v1_test_users_path, attrs
      end

      def verify_user_passowrd_for_test(token: nil, user_id:, **params)
        add_token_header(token)
        post verify_password_v1_test_user_path(user_id), params
      end

      def add_token_header(token)
        header 'Authorization', "Bearer #{token}" if token
      end
    end
  end
end

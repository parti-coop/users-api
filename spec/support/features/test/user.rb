module Features
  module Test
    module User
      def create_users_for_test(users = {})
        post v1_test_users_path, { users: users }, { 'Content-Type' => 'application/json' }
      end

      def list_users_for_test(**attrs)
        get v1_test_users_path, attrs
      end
    end
  end
end

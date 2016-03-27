module Features
  module Test
    module User
      def create_users_for_test(users = {})
        post v1_test_users_path, { users: users }, { 'Content-Type' => 'application/json' }
      end
    end
  end
end

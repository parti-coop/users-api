module Features
  module Test
    module Database
      def clean_database_for_test(token: nil)
        if token
          header 'Authorization', "Bearer #{token}"
        end
        post v1_test_database_clean_path
      end

      # TODO
      def database_should_be_clean
        database_seeds_should_be_loaded
      end

      # TODO
      def database_seeds_should_be_loaded
      end
    end
  end
end

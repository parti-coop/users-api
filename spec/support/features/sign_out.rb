module Features
  module SignOut
    include Response

    def sign_out(user_token:)
      header 'access-token', user_token[:access_token]
      header 'client', user_token[:client]
      header 'uid', user_token[:uid]
      delete destroy_v1_user_session_path
    end
  end
end


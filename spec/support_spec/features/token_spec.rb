require 'rails_helper'

describe Features::Token do
  include Features::Client
  include Features::Token
  include Features::User

  describe 'token_is_granted_by_client_credentials' do
    it 'grants token by client_credentials' do
      token = token_is_granted_by_client_credentials users_api_test_client
      token_should_be_valid token: token
    end
  end

  describe 'token_is_issued' do
    it 'issues token for user' do
      user = user_exists

      token = token_is_issued user: user

      token_should_be_valid token: token, user: user
    end
  end
end

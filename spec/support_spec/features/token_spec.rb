require 'rails_helper'

describe Features::Token do
  include Features::Client
  include Features::Token

  describe 'token_is_granted_by_client_credentials' do
    it 'grants token by client_credentials' do
      token = token_is_granted_by_client_credentials users_api_test_client
      token_should_be_valid token: token[:access_token]
    end
  end
end

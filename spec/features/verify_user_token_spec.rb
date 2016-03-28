require 'rails_helper'

describe 'Verify user token' do
  include Features

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  it 'verifies valid token' do
    user = user_exists email: 'user@email.com'
    user_token = user_token_exists(user)

    verify_user_token token: token[:access_token], user_token: user_token

    verify_token_success_should_be_rendered user: user
  end

  it 'verifies token with invalid access_token' do
    user = user_exists email: 'user@email.com'
    user_token = user_token_exists(user)
    user_token['access-token'] = 'invalid-token'

    verify_user_token token: token[:access_token], user_token: user_token

    verify_token_failure_should_be_rendered
  end

  it 'verifies token with invalid client' do
    user = user_exists email: 'user@email.com'
    user_token = user_token_exists(user)
    user_token['client'] = 'invalid-client'

    verify_user_token token: token[:access_token], user_token: user_token

    verify_token_failure_should_be_rendered
  end

  it 'verifies token with invalid uid' do
    user = user_exists email: 'user@email.com'
    user_token = user_token_exists(user)
    user_token['uid'] = 'invalid-uid'

    verify_user_token token: token[:access_token], user_token: user_token

    verify_token_failure_should_be_rendered
  end
end

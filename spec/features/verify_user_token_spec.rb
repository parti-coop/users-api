require 'rails_helper'

describe 'Verify user token' do
  include Features

  it 'verifies valid token' do
    user = user_exists email: 'user@email.com'
    token = user_token_exists(user)

    verify_user_token token

    verify_token_success_should_be_rendered user: user
  end

  it 'verifies token with invalid access_token' do
    user = user_exists email: 'user@email.com'
    token = user_token_exists(user)
    token['access-token'] = 'invalid-token'

    verify_user_token token

    verify_token_failure_should_be_rendered
  end

  it 'verifies token with invalid client' do
    user = user_exists email: 'user@email.com'
    token = user_token_exists(user)
    token['client'] = 'invalid-client'

    verify_user_token token

    verify_token_failure_should_be_rendered
  end

  it 'verifies token with invalid uid' do
    user = user_exists email: 'user@email.com'
    token = user_token_exists(user)
    token['uid'] = 'invalid-uid'

    verify_user_token token

    verify_token_failure_should_be_rendered
  end
end

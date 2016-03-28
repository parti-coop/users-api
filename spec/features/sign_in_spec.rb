require 'rails_helper'

describe 'Sign in' do
  include_context 'feature'

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  it 'responds with token with valid credential' do
    user_exists(
      email: 'one@email.com',
      password: 'Passw0rd!'
    )

    sign_in(
      email: 'one@email.com',
      password: 'Passw0rd!',
      token: token[:access_token]
    )

    user_token_in_response_should_be_valid email: 'one@email.com'
  end

  it 'responds 401 unautorized email do not exist' do
    user_does_not_exist email: 'one@email.com'

    sign_in(
      email: 'one@email.com',
      password: 'Passw0rd!',
      token: token[:access_token]
    )

    response_should_be_401_unauthorized
  end

  it 'responds 401 unautorized without email' do
    user_exists(
      email: 'one@email.com',
      password: 'Passw0rd!'
    )

    sign_in(
      password: 'Passw0rd!',
      token: token[:access_token]
    )

    response_should_be_401_unauthorized
  end

  it 'responds 401 unautorized with wrong password' do
    user_exists(
      email: 'one@email.com',
      password: 'Passw0rd!'
    )

    sign_in(
      email: 'one@email.com',
      password: 'wrong-password',
      token: token[:access_token]
    )

    response_should_be_401_unauthorized
  end

  it 'responds 401 unauthorized without token' do
    user_exists(
      email: 'one@email.com',
      password: 'Passw0rd!'
    )

    sign_in(
      email: 'one@email.com',
      password: 'Passw0rd!'
    )

    response_should_be_401_unauthorized
  end
end

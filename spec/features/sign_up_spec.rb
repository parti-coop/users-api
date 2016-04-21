require 'rails_helper'

describe 'Sign up' do
  include Features

  before :each do
    Devise.mailer.deliveries.clear
  end

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  context 'when user signs up with valid input' do
    it 'creates unconfirmed user' do
      user_does_not_exist email: 'new_user@email.com'

      sign_up(
        confirm_success_url: 'http://redirect.uri',
        email: 'new_user@email.com',
        nickname: 'new_user_nickname',
        password: 'Passw0rd!',
        token: token[:access_token]
      )

      created_user_should_be_rendered
      user_should_be_created(
        confirmed: false,
        email: 'new_user@email.com',
        nickname: 'new_user_nickname',
        password: 'Passw0rd!'
      )
      confirmation_email_should_be_sent email: 'new_user@email.com'
    end
  end

  it 'responds 401 unauthorized without token' do
    user_does_not_exist email: 'new_user@email.com'

    sign_up(
      confirm_success_url: 'http://redirect.uri',
      email: 'new_user@email.com',
      password: 'Passw0rd!'
    )
    response_should_be_401_unauthorized
  end
end

require 'rails_helper.rb'

describe 'list users for test' do
  include_context 'feature'

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  it 'lists user by email' do
    wally = user_exists email: 'wally@email.com'

    list_users_for_test(
      email: 'wally@email.com',
      token: token[:access_token]
    )

    wally.password = nil
    users_should_be_rendered [ wally ]
  end

  it 'lists empty with email not exists' do
    user_does_not_exist email: 'wally@email.com'

    list_users_for_test(
      email: 'wally@email.com',
      token: token[:access_token]
    )

    users_should_be_rendered []
  end

  it 'responds 401 unauthorized without token' do
    user_does_not_exist email: 'wally@email.com'

    list_users_for_test email: 'wally@email.com'

    response_should_be_401_unauthorized
  end
end

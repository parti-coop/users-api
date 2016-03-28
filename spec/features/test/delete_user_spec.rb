require 'rails_helper'

describe 'delete user for test' do
  include_context 'feature'

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  it 'deletes user' do
    user = user_exists email: 'user@email.com'

    delete_user_for_test(
      user_id: user.identifier,
      token: token[:access_token]
    )

    response_should_be_204_no_content
    user_should_be_deleted email: 'user@email.com'
  end

  it 'respond 401 unauthorized without token' do
    user = user_exists email: 'user@email.com'

    delete_user_for_test user_id: user.identifier

    response_should_be_401_unauthorized
  end
end

require 'rails_helper.rb'

describe 'create users for test' do
  include_context 'feature'

  let(:client) { users_api_test_client }
  let(:token) { token_is_granted_by_client_credentials client }

  it 'create a user without params' do
    create_users_for_test token: token[:access_token]

    created_users_should_be_rendered
    users_should_be_created count: 1
  end

  it 'create users with email attrs' do
    create_users_for_test(
      users: [
        { email: 'one@email.com' },
        { email: 'two@email.com' }
      ],
      token: token[:access_token]
    )

    created_users_should_be_rendered
    users_should_be_created(
      users: [
        { email: 'one@email.com' },
        { email: 'two@email.com' }
      ]
    )
  end
end

require 'rails_helper.rb'

describe 'create users for test' do
  include_context 'feature'

  it 'create a user without params' do
    create_users_for_test

    created_users_should_be_rendered
    users_should_be_created count: 1
  end

  it 'create users with email attrs' do
    create_users_for_test(
      users: [
        { email: 'one@email.com' },
        { email: 'two@email.com' }
      ]
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

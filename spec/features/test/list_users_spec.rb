require 'rails_helper.rb'

describe 'list users for test' do
  include_context 'feature'

  it 'lists user by email' do
    wally = user_exists email: 'wally@email.com'

    list_users_for_test(
      email: 'wally@email.com'
    )

    wally.password = nil
    users_should_be_rendered [ wally ]
  end

  it 'lists empty with email not exists' do
    user_does_not_exist email: 'wally@email.com'

    list_users_for_test(
      email: 'wally@email.com'
    )

    users_should_be_rendered []
  end

  xit 'responds 401 unauthorized without token' do
    user_does_not_exist email: 'wally@email.com'

    list_users_for_test email: 'wally@email.com'

    response_should_be_401_unauthorized
  end
end

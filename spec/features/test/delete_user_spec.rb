require 'rails_helper.rb'

describe 'delete user for test' do
  include_context 'feature'

  it 'deletes user' do
    user = user_exists email: 'user@email.com'

    delete_user_for_test(
      user_id: user.identifier
    )

    response_should_be_204_no_content
    user_should_be_deleted email: 'user@email.com'
  end

  xit 'respond 401 unauthorized without token' do
    user = user_exists email: 'user@email.com'

    delete_user_for_test user_id: user.id

    response_should_be_401_unauthorized
  end
end

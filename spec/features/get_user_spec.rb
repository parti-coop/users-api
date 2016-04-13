require 'rails_helper'

describe 'Get user endpoint' do
  include Features

  it 'responds user' do
    user = user_exists
    token = token_is_issued user: user

    request_get_user user: user, token: token

    user_should_be_rendered user
  end

  it 'responds 404 not found with not existing user' do
    user = user_exists
    token = token_is_issued user: user

    user.identifier = 'not-exist-user-identifier'
    request_get_user user: user, token: token

    response_should_be_404_not_found
  end

  it 'responds 401 unauthorized without token' do
    user = user_exists

    request_get_user user: user

    response_should_be_401_unauthorized
  end
end

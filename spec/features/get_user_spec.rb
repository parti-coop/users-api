require 'rails_helper'

describe 'Get user endpoint' do
  include Features

  it 'responds user' do
    user = user_exists
    token = token_is_issued user: user

    request_get_user user: user, token: token

    user_should_be_rendered user
  end
end

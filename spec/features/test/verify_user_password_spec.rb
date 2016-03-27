require 'rails_helper.rb'

describe 'verify user passowrd for test' do
  include_context 'feature'

  it 'responds true with correct password' do
    user = user_exists(
      email: 'wally@email.com',
      password: 'Passw@rd'
    )

    verify_user_passowrd_for_test(
      user_id: user.identifier,
      password: 'Passw@rd'
    )
    response_should_be_true
  end

  it 'responds false with wrong password' do
    user = user_exists(
      email: 'wally@email.com',
      password: 'Passw@rd'
    )

    verify_user_passowrd_for_test(
      user_id: user.identifier,
      password: 'wrong-password'
    )
    response_should_be_false
  end

  it 'responds 400 bad request without password' do
    user = user_exists(
      email: 'wally@email.com',
      password: 'Passw@rd'
    )

    verify_user_passowrd_for_test(
      user_id: user.identifier
    )

    response_should_be_400_bad_request
  end

  xit 'responds 401 unauthorized without token' do
    user = user_exists(
      email: 'wally@email.com',
      password: 'Passw@rd'
    )

    verify_user_passowrd_for_test(
      user_id: user.id,
      password: 'wrong-password'
    )

    response_should_be_401_unauthorized
  end
end

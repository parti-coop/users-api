require 'rails_helper'

describe 'Confirm sign-up' do
  include_context 'feature'

  it 'succeeds to confirm sign-up' do
    confirmation_link = user_signs_up_then_gets_confirm_link(
      email: 'user@email.com'
    )

    get confirmation_link

    confirmed_sign_up_should_be_rendered
    user_sign_up_should_be_confirmed(
      email: 'user@email.com',
    )
  end
end

require 'rails_helper'
require 'test/factories'

describe 'factories' do
  describe 'user' do
    it 'creates confirmed user by default' do
      user = FactoryGirl.create :user

      user.reload
      expect(user).to be_confirmed
    end

    it 'creates unconfirmed' do
      user = FactoryGirl.create :user, confirm: false

      user.reload
      expect(user).not_to be_confirmed
    end
  end
end

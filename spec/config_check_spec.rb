require 'rails_helper'

describe 'ENV variables', smoke: true do
  describe 'USERS_API_TEST_CLIENT_ID' do
    it { expect(ENV['USERS_API_TEST_CLIENT_ID']).to be_present }
  end

  describe 'USERS_API_TEST_CLIENT_SECRET' do
    it { expect(ENV['USERS_API_TEST_CLIENT_SECRET']).to be_present }
  end
end

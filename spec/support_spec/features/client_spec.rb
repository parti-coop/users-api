require 'rails_helper'

describe Features::Client do
  subject do
    Class.new do
      include Features::Client
    end.new
  end

  describe 'users_api_test_client' do
    it 'raises excpetion when USERS_API_TEST_CLIENT_ID is empty' do
      allow(ENV).to receive(:[]).with('USERS_API_TEST_CLIENT_SECRET').and_return('not empty value')
      allow(ENV).to receive(:[]).with('USERS_API_TEST_CLIENT_ID').and_return(nil)
      expect do
        subject.users_api_test_client
      end.to raise_error('Missing USERS_API_TEST_CLIENT_ID')
    end

    it 'raises excpetion when USERS_API_TEST_CLIENT_SECRET is empty' do
      allow(ENV).to receive(:[]).with('USERS_API_TEST_CLIENT_ID').and_return('not empty value')
      allow(ENV).to receive(:[]).with('USERS_API_TEST_CLIENT_SECRET').and_return(nil)
      expect do
        subject.users_api_test_client
      end.to raise_error('Missing USERS_API_TEST_CLIENT_SECRET')
    end
  end
end

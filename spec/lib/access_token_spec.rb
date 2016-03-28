require 'rails_helper'

require 'access_token.rb'

describe AccessToken do
  include PartiUrl

  describe '#from' do
    it 'create AccessToken instance' do
      access_token = AccessToken.from('token-string')
      expect(access_token).to be_an(AccessToken)
    end
  end

  describe '#active?' do
    it 'responds true with active token' do
      fake_token = 'fake_token'
      stub_request(:post, auth_api_introspect_url).with(
        headers: { 'Authorization': "Bearer #{fake_token}" },
        body: { token: fake_token }
      ).to_return(
        status: 200,
        body: { active: true }.to_json
      )
      access_token = AccessToken.from fake_token
      expect(access_token.active?).to be true
    end

    it 'raise exception when server response is not ok' do
      stub_request(:post, auth_api_introspect_url).to_return(status: [500, 'status text'])
      access_token = AccessToken.from 'ignore-token'
      expect{ access_token.active? }.to raise_error do |error|
        expect(error).to be_a(Rack::OAuth2::Server::Abstract::Error)
        expect(error.status).to eq(500)
        expect(error.error).to eq('status text')
      end
    end
  end
end

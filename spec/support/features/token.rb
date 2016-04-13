require 'faraday'

module Features
  module Token
    include PartiUrl

    def token_is_granted_by_client_credentials(client_id:, client_secret:)
      conn = auth_api_conn
      conn.basic_auth(client_id, client_secret)
      response = conn.post do |req|
        req.url '/v1/tokens'
        req.body = { grant_type: 'client_credentials' }
      end
      expect(response.status).to eq(200)
      JSON.parse(response.body).with_indifferent_access
    end

    def token_is_issued(token: nil, user:)
      token ||= token_is_granted_by_client_credentials users_api_test_client
      account = find_or_create_account user: user, token: token
      issue_token account: account, token: token
    end

    def find_or_create_account(user:, token:)
      response = auth_api_conn.post do |req|
        req.url '/v1/test/user-accounts'
        req.headers['Authorization'] = "Bearer #{token[:access_token]}"
        req.body = { attrs_set: [ parti: { identifier: user.identifier } ] }
      end
      JSON.parse(response.body).first.with_indifferent_access
    end

    def issue_token(account:, token:)
      response = auth_api_conn.post do |req|
        req.url "/v1/test/user-accounts/#{account[:identifier]}/tokens"
        req.headers['Authorization'] = "Bearer #{token[:access_token]}"
      end
      JSON.parse(response.body).with_indifferent_access
    end

    def token_should_be_valid(token:, **rest)
      response = auth_api_conn.post do |req|
        req.url '/v1/introspect'
        req.headers['Authorization'] = "Bearer #{token[:access_token]}"
        req.body = { token: token[:access_token] }
      end
      expect(response.status).to eq(200)
      body = JSON.parse(response.body).with_indifferent_access
      if rest[:user]
        expect(body[:grant_type]).to eq('authorization_code')
        expect(body[:connect_type]).to eq('parti')
        expect(body[:connect_id]).to eq(rest[:user].identifier)
      end
    end

    def auth_api_conn
      Faraday.new url: auth_api_base_url
    end
  end
end

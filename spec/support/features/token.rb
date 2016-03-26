require 'faraday'

module Features
  module Token
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

    def token_should_be_valid(token:)
      response = auth_api_conn.post do |req|
        req.url '/v1/introspect'
        req.headers['Authorization'] = "Bearer #{token}"
        req.body = { token: token }
      end
      expect(response.status).to eq(200)
    end

    def auth_api_conn
      Faraday.new url: auth_api_base_url
    end

    def auth_api_base_url
      "#{ENV['AUTH_API_SCHEME']}://#{ENV['AUTH_API_HOST']}:#{ENV['AUTH_API_PORT']}"
    end
  end
end

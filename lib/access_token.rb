class AccessToken
  include PartiUrl

  def self.from(token)
    AccessToken.new token
  end

  def token
    @token
  end

  def active?
    introspect[:active]
  end

  protected

  def initialize(token)
    @token = token
  end

  def access_token
    @access_token ||= Rack::OAuth2::AccessToken::Bearer.new access_token: token
  end

  def introspect
    @introspect || introspect!
  end

  def introspect!
    response = access_token.post auth_api_introspect_url, token: token
    unless response.ok?
      raise Rack::OAuth2::Server::Abstract::Error.new(response.status,response.reason)
    end
    ActiveSupport::HashWithIndifferentAccess.new JSON.parse(response.body)
  end
end

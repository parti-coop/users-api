module PartiUrl
  def auth_api_introspect_url
    auth_api_url '/v1/introspect'
  end

  def auth_api_url(path)
    URI.join(auth_api_base_url, path).to_s
  end

  def auth_api_base_url
    "http://#{auth_api_host}:#{auth_api_port}"
  end

  def auth_api_host()
    ENV['AUTH_API_HOST'] || 'auth-api'
  end

  def auth_api_port()
    correct_docker_link_port ENV['AUTH_API_PORT'], 3030
  end

  def correct_docker_link_port(port, default)
    case port
    when /^(\d+)$/
      $1.to_i
    when /^tcp:\/\/.+:(\d+)$/
      $1.to_i
    else
      default
    end
  end
end

class V1::SessionsController < DeviseTokenAuth::SessionsController
  include Concerns::Authentication

  before_action :require_access_token
end

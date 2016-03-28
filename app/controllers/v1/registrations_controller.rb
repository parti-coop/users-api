class V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include Concerns::Authentication

  before_action :require_access_token
end

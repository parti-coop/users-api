class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::ParameterMissing, :with => :bad_request

  def bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end
end

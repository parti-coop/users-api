class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Concerns::Authentication

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  rescue_from ActionController::ParameterMissing, :with => :bad_request
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, :with => :unprocessable_entity
  rescue_from ActiveRecord::RecordInvalid, :with => :unprocessable_entity

  def bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def unprocessable_entity(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end

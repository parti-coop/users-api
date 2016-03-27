class V1::Test::UsersController < ApplicationController
  include ::Test::Factories::User

  def index
    users = User.where(index_params)
    render status: 200, json: users
  end

  def index_params
    params.permit :email
  end

  def create
    attrs = create_params.to_h[:users] || [{}]
    users = users_exist attrs
    render status: 200, json: users
  end

  def create_params
    params.permit users: [:email, :password]
  end

  def destroy
    user = User.find_by_identifier! params[:identifier]
    user.destroy
    render :nothing, status: 204
  end

  def verify_password
    identifier, password = verify_password_params.values_at :identifier, :password
    user = User.find_by_identifier! identifier
    render status: 200, json: user.valid_password?(password)
  end

  def verify_password_params
    params.require(:password)
    params.permit :identifier, :password
  end
end

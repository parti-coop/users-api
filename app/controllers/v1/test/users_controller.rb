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
end

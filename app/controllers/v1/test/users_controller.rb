class V1::Test::UsersController < ApplicationController
  include ::Test::Factories::User

  def index
    render :nothing, status: 200
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

class V1::UsersController < ApplicationController
  before_action :require_access_token

  def show
    user = User.find_by_identifier! params[:identifier]
    render status: 200, json: user
  end
end

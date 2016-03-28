class V1::Test::DatabaseController < ApplicationController
  before_action :require_access_token

  def clean
    if Rails.env.test?
      DatabaseCleaner.clean_with(:truncation)
      load "#{Rails.root}/db/seeds.rb"
      render :nothing, status: 204
    else
      render :status => :forbidden, :text => 'Forbidden'
    end
  end
end

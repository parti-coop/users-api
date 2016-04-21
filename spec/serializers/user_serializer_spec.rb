require 'rails_helper'

describe UserSerializer do
  include Features::User

  it 'serializes user' do
    user = user_exists
    user_json = ActiveModel::SerializableResource.new(user).to_json
    expect(user_json).to be_json_eql(<<-JSON).excluding('password')
      {
        "identifier": "#{user.identifier}",
        "email": "#{user.email}",
        "nickname": "#{user.nickname}"
      }
    JSON
  end
end

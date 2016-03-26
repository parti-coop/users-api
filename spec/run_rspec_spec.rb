require 'rails_helper'

describe RSpec do
  it 'runs with rack-test' do
    get v1_test_users_path
    expect(last_response.status).to eq(200)
  end
end

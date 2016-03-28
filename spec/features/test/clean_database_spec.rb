require 'rails_helper'

describe 'clean database for test' do
  include_context 'feature'

  it 'clean database' do
    client = client_exists
    token = token_is_granted_by_client_credentials client

    clean_database_for_test token: token[:access_token]

    response_should_be_204_no_content
    database_should_be_clean
  end
end

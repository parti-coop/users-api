shared_context 'feature' do
  include Features

  before :each do
    Test::ActiveRecord.clear_createds
  end
end

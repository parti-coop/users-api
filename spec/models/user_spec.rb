require 'rails_helper'

describe User do
  it 'has identifier after creation' do
    user = FactoryGirl.build :user
    expect(user.identifier).to be_nil
  end

  it 'is valid without identifier before creation' do
    user = FactoryGirl.build :user
    expect(user.valid?).to be true
  end

  it 'is has identifier after creation' do
    user = FactoryGirl.build :user
    user.save!
    expect(user.identifier).to be_present
  end
end

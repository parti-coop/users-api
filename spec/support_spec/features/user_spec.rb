require 'rails_helper'

describe Features::User do
  subject do
    Class.new do
      include Features::User
    end.new
  end

  describe :user_does_not_exist do
    context 'when the user exist' do
      before :each do
        FactoryGirl.create :user, email: 'the_user@email.com'
        FactoryGirl.create :user, email: 'another_user@email.com'
      end

      it 'deletes the user' do
        expect do 
          subject.user_does_not_exist email: 'the_user@email.com'
        end.to change{ User.count }.by(-1)
        expect(User.find_by_email 'the_user@email.com').to be_blank
      end
    end

    context 'when the user does not exist' do
      before :each do
        User.where(email: 'the_user@email.com').destroy_all
        FactoryGirl.create :user, email: 'another_user@email.com'
      end

      it 'does not change users' do
        expect do
          subject.user_does_not_exist email: 'the_user@email.com'
        end.not_to change{ User.count }
      end
    end
  end
end


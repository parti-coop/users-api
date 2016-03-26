module Features
  module User
    def user_does_not_exist(email:)
      ::User.where(email: email).destroy_all
    end

    def user_should_be_created(attrs)
      last_user = ::User.createds.last
      expect(last_user.confirmed?).to eq(attrs[:confirmed]) if attrs[:confirmed]
      expect(last_user.email).to eq(attrs[:email])
      expect(last_user.valid_password? attrs[:password]).to be true
    end
  end
end

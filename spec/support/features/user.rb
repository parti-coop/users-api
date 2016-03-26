module Features
  module User
    def user_does_not_exist(email:)
      ::User.where(email: email).destroy_all
    end
  end
end

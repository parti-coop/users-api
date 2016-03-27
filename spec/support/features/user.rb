module Features
  module User
    include Features::Response
    include ::Test::Factories::User

    def user_does_not_exist(email:)
      ::User.where(email: email).destroy_all
    end

    def user_should_be_created(attrs)
      last_user = ::User.createds.last
      expect(last_user.confirmed?).to eq(attrs[:confirmed]) if attrs[:confirmed]
      expect(last_user.email).to eq(attrs[:email])
      expect(last_user.valid_password? attrs[:password]).to be true
    end

    def created_user_should_be_rendered
      response_should_be_200_ok_json

      last_user = ::User.createds.last
      expect(last_response.body).to be_json_eql(<<-JSON)
      {
        "status": "success",
        "data": {
          "id": "#{last_user.id}",
          "identifier": "#{last_user.identifier}",
          "provider": "email",
          "uid":"#{last_user.email}",
          "name":null,
          "nickname":null,
          "image":null,
          "email":"#{last_user.email}"
        }
      }
      JSON
    end

    def created_users_should_be_rendered
      users_should_be_rendered(::User.createds)
    end

    def users_should_be_rendered(users)
      response_should_be_200_ok_json
      users_json = ActiveModel::SerializableResource.new(users).to_json
      expect(last_response.body).to be_json_eql(users_json)
    end

    def users_should_be_created(params)
      if params[:count]
        expect(::User.createds.size).to eq(params[:count])
      end
      if params[:attrs_set]
        ::User.createds.zip(params[:attrs_set]).each do |user, attrs|
          expect(user.attributes.symbolize_keys.slice(*attrs.keys)).to eq(attrs)
        end
      end
    end

    def user_should_be_deleted(attrs)
      users = ::User.where(attrs)
      expect(users).to be_empty
    end
  end
end

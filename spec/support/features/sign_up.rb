module Features
  module SignUp
    include Response
    def sign_up(params)
      post v1_user_registration_path params
    end

    def created_user_should_be_rendered
      response_should_be_200_ok_json

      last_user = ::User.createds.last
      expect(last_response.body).to be_json_eql(<<-JSON)
      {
        "status": "success",
        "data": {
          "id": "#{last_user.id}",
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

    def confirmation_email_should_be_sent(params)
      last_email = Devise.mailer.deliveries.last
      expect(last_email).to deliver_to(params[:email])
      confirmation_token = ::User.createds.last.confirmation_token
      expect(last_email).to have_body_text("confirmation_token=#{confirmation_token}")
    end
  end
end

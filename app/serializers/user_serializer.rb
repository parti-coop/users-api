class UserSerializer < ActiveModel::Serializer
  attributes :created_at, :email, :identifier, :nickname, :password

  def attributes(*args)
    data = super
    if object.password.nil?
      data = data.except(:password)
    end
    data
  end
end

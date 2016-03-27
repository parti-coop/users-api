class UserSerializer < ActiveModel::Serializer
  attributes :identifier, :email, :password, :created_at

  def attributes(*args)
    data = super
    if object.password.nil?
      data = data.except(:password)
    end
    data
  end
end

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :confirmable

  include DeviseTokenAuth::Concerns::User

  before_validation :setup, on: :create
  validates :identifier, length: { minimum: 0, allow_nil: false }, uniqueness: true

  def setup
    self.identifier = SecureRandom.hex(8)
  end
end

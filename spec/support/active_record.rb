module UsersApi::Test
  MODELS = [User]

  def self.setup_createds
    MODELS.each do |klass|
      klass.class_eval do
        cattr_accessor :createds
        klass.createds = []
        after_create do
          self.class.createds << self
        end
      end
    end
  end

  def self.clear_createds
    MODELS.each do |klass|
      klass.createds = []
    end
  end

  setup_createds
end

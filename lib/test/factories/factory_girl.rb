require 'factory_girl'

FactoryGirl.define do
  sequence(:seq) { |n| n }

  factory :user do
    transient do
      seq { generate :seq }
      confirm true
    end
    email { "user-#{seq}@email.com" }
    password 'Passw0rd1!'
    after :create  do |user, evaluator|
      if evaluator.confirm
        user.confirm
      end
    end
  end
end

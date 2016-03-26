FactoryGirl.define do
  sequence(:seq) { |n| n }

  factory :user do
    transient do
      seq { generate :seq }
    end
    email { "user-#{seq}@email.com" }
    password 'Passw0rd1!'
  end
end

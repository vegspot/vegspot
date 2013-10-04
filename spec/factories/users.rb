require 'faker'

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    password "SamplePassword"
    email

    trait :admin do
      is_admin true
    end
  end
end
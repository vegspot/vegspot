require 'faker'

FactoryGirl.define do
  factory :user do
    password "SamplePassword"
    sequence(:email) { |n| "person#{n}@example.com" }

    trait :admin do
      is_admin true
    end
  end
end
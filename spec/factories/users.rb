require 'faker'

FactoryGirl.define do
  factory :user do
    password "SamplePassword"

    factory :admin_user do
      sequence(:email) { |n| "person#{n}@example.com" }
      is_admin true
    end

    factory :regular_user do
      sequence(:email) { |n| "person#{n}@example.com" }
    end

    factory :regular_user_2 do
      sequence(:email) { |n| "person#{n}@example.com" }
    end
  end
end
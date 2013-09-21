require 'faker'

FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentence(20)

    association :user, factory: :regular_user
  end
end
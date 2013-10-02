require 'faker'

FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentence(20)

    association :user, factory: :user
    association :commentable, factory: :node
  end
end
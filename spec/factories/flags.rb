# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flag do
    flagged_type "Node"
    description  Faker::Lorem.sentence(10)
    association  :user, factory: :user
    association :flagged, factory: :node

    trait :needs_thumb do
      key "needs_thumb"
    end

    trait :spam do
      key "spam"
    end
  end
end

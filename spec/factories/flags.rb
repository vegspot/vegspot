# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flag do
    factory :needs_thumb_flag do
      key          "needs_thumb"
      flagged_type "Node"
      description  "Test description"
      flagged_id   1

      association :user, factory: :regular_user_2
      # No idea why it's not working...
      # association :flagged_id, factory: :link_node
    end

    factory :spam_flag do
      key "spam"
      flagged_type "Node"
      description "This node is a spam for sure"
      flagged_id 1

      association :user, factory: :regular_user
    end
  end
end
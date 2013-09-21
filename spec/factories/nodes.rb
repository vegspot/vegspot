FactoryGirl.define do
  factory :node do
    tag_list Faker::Lorem.sentence(5)

    factory :link_node do
      title      Faker::Lorem.sentence(5)
      url        "http://wegannerd.blogspot.com/2013/08/totalny-burger-king-z-batatow-i.html"
      created_at Date.today - 5.days
      node_type  0

      association :user, factory: :regular_user_2
    end

    factory :text_node do
      title      Faker::Lorem.sentence(5)
      body       Faker::Lorem.sentence(20)
      thumbnail  Faker::Lorem.sentence(1)
      created_at Date.today - 12.days
      node_type  1

      association :user, factory: :regular_user_2
    end

    factory :week_ago_node do
      title      "Node added 7 days ago"
      body       "This node tests if nodes added exactly 7 days ago are included in this_week scope."
      thumbnail  Faker::Lorem.sentence(1)
      created_at Date.today - 7.days
      node_type  1

      association :user, factory: :regular_user
    end

    factory :month_ago do
      title      "Node added 1 month ago"
      body       "This node tests if nodes added exactly 1 month ago are included in this_week scope."
      thumbnail  Faker::Lorem.sentence(1)
      created_at Date.today - 1.month
      node_type  1

      association :user, factory: :regular_user
    end
  end
end
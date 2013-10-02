FactoryGirl.define do
  factory :node do
    tag_list        Faker::Lorem.sentence(5)
    title           Faker::Lorem.sentence(5)
    created_at      Date.today - 5.days
    thumbnail       Faker::Lorem.sentence(1)
    url             "http://wegannerd.blogspot.com/2013/08/totalny-burger-king-z-batatow-i.html"
    shares_facebook 0
    shares_twitter  0
    association :user, factory: :user

    trait :week_ago do
      created_at Date.today - 7.days
    end

    trait :month_ago do
      created_at Date.today - 1.month
    end

    trait :with_comments do
      after(:create) do |instance|
        create_list :comment, 3, commentable: instance
      end
    end
  end
end
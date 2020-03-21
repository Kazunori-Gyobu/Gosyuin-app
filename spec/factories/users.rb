FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    confirmed_at { Date.today }

    trait :with_posts do
      after(:create) { |user| create_list(:post, 5, user: user) }
    end
  end
end

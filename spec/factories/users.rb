FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    confirmed_at { Date.today }
  end
end

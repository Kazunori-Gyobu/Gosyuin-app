FactoryBot.define do
  factory :post do
    content { "MyText" }
    picture { "MyString" }
    association :user
  end
end

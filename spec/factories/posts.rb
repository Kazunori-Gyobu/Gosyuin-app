FactoryBot.define do
  factory :post do
    content { "MyText" }
    picture { "MyString" }
    user { nil }
  end
end

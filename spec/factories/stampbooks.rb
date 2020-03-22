FactoryBot.define do
  factory :stampbook do
    name { "MyString" }
    given_date { "2020-03-21" }
    cover { "MyString" }
    remarks { "MyText" }
    type { "" }
    user
  end
end

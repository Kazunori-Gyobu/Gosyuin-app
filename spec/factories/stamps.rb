FactoryBot.define do
  factory :stamp do
    name { "MyString" }
    given_date { "2020-03-28" }
    photo { "MyString" }
    remarks { "MyText" }
    distinction { "MyString" }
    stampbook { nil }
  end
end

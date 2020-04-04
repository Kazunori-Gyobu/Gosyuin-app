FactoryBot.define do
  factory :stamp do
    name { "MyString" }
    given_date { "2020-03-28" }
    photo { nil }
    remarks { "MyText" }
    distinction { "MyString" }
    stampbook { nil }
    user

    trait :with_photo do
      photo { File.new("#{Rails.root}/spec/fixtures/sample.jpeg") }
    end
  end
end

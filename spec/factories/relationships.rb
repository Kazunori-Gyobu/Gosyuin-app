FactoryBot.define do
  factory :relationship do
    association :follower, factory: :user
    association :followed, factory: :user, email: 'another@test.com'
  end
end

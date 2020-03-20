require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  let(:active) { user.active_relationships.build(followed_id: another_user.id) }

  subject { active }

  it "フォローの関係性が有効であること" do
    is_expected.to be_valid
  end

  describe "follower/followedメソッドの有効性" do

    it "フォロー中のユーザーを返すこと" do
      expect(active.follower).to eq user
    end

    it "フォローされているユーザーを返すこと" do
      expect(active.followed).to eq another_user
    end
  end

  describe "validations" do
    it "followed_idが存在すること" do
      is_expected.to validate_presence_of :followed_id
    end

    it "follower_idが存在すること" do
      is_expected.to validate_presence_of :follower_id
    end
  end
end

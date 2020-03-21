require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  describe "記事の有効性" do

    it "記事がなければ無効なこと" do
      post.content = ""
      expect(post).to_not be_valid
    end

    it "user_idがなければ無効なこと" do
      post.user_id = nil
      expect(post).to_not be_valid
    end

    it "記事の文字数が140文字以内であること" do
      post.content = "a" * 141
      expect(post).to_not be_valid
    end
  end

  describe "投稿の並び順" do
    let!(:older_post) { FactoryBot.create(:post, user_id: user.id, created_at: 1.day.ago) }
    let!(:resent_post) { FactoryBot.create(:post, user_id: user.id, created_at: Time.zone.now) }
    let!(:newer_post) { FactoryBot.create(:post, user_id: user.id, created_at: 1.hour.ago) }

    it "最新の投稿が最初にあるか" do
      expect(Post.all).to eq [resent_post, newer_post, older_post]
    end
  end

  describe "ユーザーに紐付いた投稿" do

    it "アカウント削除で共に削除されること" do
      user.posts.create!(content: "add a post")
      expect do
        user.destroy
      end.to change(Post, :count).by(-1)
    end
  end
end
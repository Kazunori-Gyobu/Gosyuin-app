require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }

  it "ログインしていなければリダイレクトされること" do
    post posts_path
    expect(response).to redirect_to new_user_session_path
  end

  describe "記事の削除" do
    it "ログインしていなければ削除できないこと" do
      expect {
        delete post_path(post1)
      }.to change{ user.posts.count }.by(0)
    end
  end
end
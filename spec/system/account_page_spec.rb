require 'rails_helper'

RSpec.describe "アカウントページ", type: :system do
  let(:user) { FactoryBot.create(:user, :with_posts) }

  describe "アカウントページの表示" do
    it "タイトル、ユーザー名、投稿記事が表示されていること" do
      sign_in user
      visit user_path(user)
      expect(page).to have_selector "title", text: "Example User", visible: false
      expect(page).to have_selector "h3", text: "Example User"
      expect(page).to have_content "投稿(5)"
      expect(page).to have_css ".posts"
    end
  end
end
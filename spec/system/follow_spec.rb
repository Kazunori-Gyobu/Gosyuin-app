require 'rails_helper'

RSpec.describe "Follow", type: :system, js: true do
  let!(:user) { FactoryBot.create(:user, name: "斎藤") }
  let!(:another_user) { FactoryBot.create(:user, name: "山本") }
  let!(:active) { user.active_relationships.create(followed_id: another_user.id) }

  before do
    sign_in user
  end

  describe "フォロー/フォロー解除のボタン" do

    it "フォローしているユーザーの名前があること" do
      visit user_path(user)
      click_link "following"
      expect(current_path).to eq following_user_path(user)
      expect(page).to have_content "山本"

      click_link "山本"
      expect(current_path).to eq user_path(another_user)
      expect(page).to have_selector ".edit_relationship"
      expect {
        click_button "フォロー解除"
      }.to change { user.following.count }.by(-1)

    end
  end
end
require 'rails_helper'

RSpec.describe "Users update", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe "アカウント情報の更新" do

    before do
      sign_in user
      visit edit_user_registration_path
    end

    it "名前の変更が出来ること" do
      fill_in "user_name", with: "京都太郎"
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。"
      expect(page).to have_content "京都太郎"
    end

    it "メールアドレスの変更が出来ること" do
      fill_in "user_email", with: "kyoto@example.com"
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。"
    end

  end
end
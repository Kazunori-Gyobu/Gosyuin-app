require 'rails_helper'

RSpec.describe "Users signup", type: :system do
  before do
    visit new_user_registration_path
  end

  describe "有効なユーザーの場合" do
    before do
      fill_in "user_name", with: "テストユーザー"
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_button "アカウント登録"
    end
    it "メールが送られること" do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
    it "ルートにリダイレクトされること" do
      expect(current_path).to eq(root_path)
    end
  end
end
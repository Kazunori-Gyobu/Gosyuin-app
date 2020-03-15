require 'rails_helper'

RSpec.describe "Users login", type: :system do
  describe "ログイン操作" do
    
    before do
      visit new_user_session_path
    end

    context "有効なログインの場合" do
      before do
        @user = FactoryBot.create(:user, name: "Example User", email: "email@example.com")
        fill_in "user_email", with: "email@example.com"
        fill_in "user_password", with: "foobar"
        click_button "ログイン"
      end
      it "ユーザーページにリダイレクトされること" do
        expect(current_path).to eq(user_path(@user))
      end
      it "ユーザー画面が表示されていること" do
        expect(page).to have_content "Example User"
      end
    end

    context "無効なログインの場合" do
      before do
        fill_in "user_email", with: ""
        fill_in "user_password", with: ""
        click_button "ログイン"
      end
      it "エラーが表示されること" do
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
  end
end
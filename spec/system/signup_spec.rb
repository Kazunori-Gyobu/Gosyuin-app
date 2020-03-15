require 'rails_helper'

RSpec.describe "Users signup", type: :system do
  describe "登録画面の入力" do

    before do
      visit new_user_registration_path
    end

    context "有効なユーザーの場合" do
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

    context "無効なユーザーの場合" do
      before do
        click_button "アカウント登録"
      end
      it "メールが送られないこと" do
        expect(ActionMailer::Base.deliveries.size).to_not eq(1)
      end
      it "ルートにリダイレクトされないこと" do
        expect(current_path).to_not eq(root_path)
      end
      it "名前のエラーメッセージが表示されること" do
        expect(page).to have_content "名前を入力してください"
      end
      it "メールアドレスのエラーメッセージが表示されること" do
        expect(page).to have_content "メールアドレスを入力してください"
      end
      it "パスワードのエラーメッセージが表示されること" do
        expect(page).to have_content "パスワードを入力してください"
      end
    end
  end
end
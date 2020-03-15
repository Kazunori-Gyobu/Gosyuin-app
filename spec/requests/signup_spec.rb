require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET #edit" do

    context "ログインしているユーザーの場合" do
      it "editリクエストが成功すること" do
        sign_in user
        get edit_user_registration_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get edit_user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH #update" do
    
    context "認可されたユーザーの場合" do
      it "更新出来ること" do
        sign_in user
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        patch user_registration_path, params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "NewName"
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページにリダイレクトされること" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        patch user_registration_path, params: { id: user.id, user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
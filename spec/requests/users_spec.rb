require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET #index" do

    it "indexリクエストが成功すること" do
      get users_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "user名が表示されること" do
      get users_path
      expect(response.body).to include "user"
    end
  end

  describe "GET #new" do
    it "newリクエストが成功すること" do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do

    context "ログイン済みのユーザーの時" do
      it "showリクエストが成功すること" do
        sign_in user
        get user_path(user)
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしていないユーザーの時" do
      it "ログイン画面にリダイレクトされること" do
        get user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
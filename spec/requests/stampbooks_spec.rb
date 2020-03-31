require 'rails_helper'

RSpec.describe "Stampbooks", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:stampbook) { FactoryBot.create(:stampbook, user_id: user.id) }

  describe "Get #new" do

    it "ログインしていなければリダイレクトされること" do
      get new_stampbook_path
      expect(response).to redirect_to new_user_session_path
    end

    it "newリクエストが成功すること" do
      sign_in user
      get new_stampbook_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "Post #create" do

    before do
      sign_in user
      get new_stampbook_path
    end
    
    it "御朱印帳名がなければ登録できないこと" do
      expect {
        post stampbooks_path, params: { stampbook: { name: "" } }
      }.not_to change{ user.stampbooks.count }
    end

    it "御朱印帳名があれば登録できること" do
      expect {
        post stampbooks_path, params: { stampbook: { name: "清水寺" } }
      }.to change{ user.stampbooks.count}. by(1)
    end
  end

  describe "Get #edit" do
    
    it "ログインしていなければリダイレクトされること" do
      get edit_stampbook_path(stampbook)
      expect(response).to redirect_to new_user_session_path
    end

    it "editリクエストが成功すること" do
      sign_in user
      get edit_stampbook_path(stampbook)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
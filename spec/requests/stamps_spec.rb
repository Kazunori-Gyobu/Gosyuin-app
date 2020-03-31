require 'rails_helper'

RSpec.describe "Stamps", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:stampbook) { FactoryBot.create(:stampbook, user_id: user.id) }
  let(:stamp) { FactoryBot.create(:stamp, :with_photo, user: user, stampbook: stampbook) }

  describe "Get #new" do
    it "ログインしていなければリダイレクトされること" do
      get new_stamp_path
      expect(response).to redirect_to new_user_session_path
    end

    it "newリクエストが成功すること" do
      sign_in user
      get new_stamp_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "Post #create" do

    let(:photo_path) { File.join(Rails.root, 'spec/fixtures/sample.jpeg') }
    let(:photo) { Rack::Test::UploadedFile.new(photo_path) }

    before do
      sign_in user
      get new_stamp_path
    end

    it "必要事項が入力されていれば登録できること" do
      expect {
        post stamps_path, params: { stamp: { name: "八坂神社",
          photo: photo,
          stampbook_id: stampbook.id
          }}
        }.to change { user.stamps.count }.by(1)
    end

    it "御朱印名がなければ登録できないこと" do
      expect {
        post stamps_path, params: { stamp: { name: "" } }
      }.not_to change{ user.stamps.count }
    end

    it "画像がなければ登録できないこと" do
      expect {
        post stamps_path, params: { stamp: { name: "八坂神社",
          photo: "",
          stampbook_id: stampbook.id
          }}
        }.not_to change { user.stamps.count }
    end

    it "登録先の御朱印帳を選ばないと登録できないこと" do
      expect {
        post stamps_path, params: { stamp: { name: "八坂神社",
          photo: "photo",
          stampbook_id: ""
          }}
        }.not_to change { user.stamps.count }
    end
  end

  describe "Get #edit" do

    it "ログインしていなければリダイレクトされること" do
      get edit_stamp_path(stamp)
      expect(response).to redirect_to new_user_session_path
    end

    it "editリクエストが成功すること" do
      sign_in user
      get edit_stamp_path(stamp)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
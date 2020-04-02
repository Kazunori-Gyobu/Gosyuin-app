require 'rails_helper'

RSpec.describe "Stampbooks", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit root_path
    click_on "御朱印帳を登録する"
  end

  describe "御朱印帳の登録" do

    it "新しい御朱印帳が登録できること" do
      expect {
        fill_in "御朱印帳名", with: "清水寺"
        fill_in "stampbook_given_date", with: "2020/3/30"
        choose "stampbook_distinction_寺院"
        click_on "送信"
  
        expect(page).to have_content "御朱印帳が登録されました！"
      }.to change(user.stampbooks, :count).by(1)
    end
  end

end
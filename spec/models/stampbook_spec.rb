require 'rails_helper'

RSpec.describe Stampbook, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:stampbook) { FactoryBot.create(:stampbook) }

  it "御朱印帳が有効であること" do
    expect(stampbook).to be_valid
  end

  it "名前がなければ無効なこと" do
    stampbook.name = ""
    expect(stampbook).to_not be_valid
  end

  it "user_idがなければ無効なこと" do
    stampbook.user_id = nil
    expect(stampbook).to_not be_valid
  end

  it "アカウント削除で共に削除されること" do
    user.stampbooks.create!(name: "清水寺")
    expect {
      user.destroy
    }.to change(Stampbook, :count).by(-1)
  end
end

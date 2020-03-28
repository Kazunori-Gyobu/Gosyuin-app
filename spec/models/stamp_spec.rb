require 'rails_helper'

RSpec.describe Stamp, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:stampbook) { FactoryBot.create(:stampbook, user_id: user.id) }
  let!(:stamp) { FactoryBot.create(:stamp, stampbook_id: stampbook.id) }

  it "御朱印が有効であること" do
    expect(stamp).to be_valid
  end

  it "名前がなければ無効なこと" do
    stamp.name = ""
    expect(stamp).to_not be_valid
  end

  it "stampbook_idがなければ無効なこと" do
    stamp.stampbook_id = nil
    expect(stamp).to_not be_valid
  end

  it "御朱印帳削除で共に削除されること" do
    expect {
      stampbook.destroy
    }.to change(Stamp, :count).by(-1)
  end
end

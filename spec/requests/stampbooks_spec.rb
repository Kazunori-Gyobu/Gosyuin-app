require 'rails_helper'

RSpec.describe "Stampbooks", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:stampbook) { FactoryBot.create(:stampbook) }

  it "ログインしていなければリダイレクトされること" do
    get new_stampbook_path
    expect(response).to redirect_to new_user_session_path
  end
end
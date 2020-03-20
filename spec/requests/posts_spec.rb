require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:anotheruser) { FactoryBot.create(:user, name: "Another User") }

  it "ログインしていなければリダイレクトされること" do
    post posts_path
    expect(response).to redirect_to new_user_session_path
  end
end
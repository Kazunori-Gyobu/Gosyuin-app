require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:anotheruser) { FactoryBot.create(:user, name: "Another User") }

  it "ログインしていなければリダイレクトされること" do
    post microposts_path
    expect(response).to redirect_to login_url
  end
end
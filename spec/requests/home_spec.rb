require 'rails_helper'

RSpec.describe "Home page", type: :request do
  describe "GET /home" do
    it "rootへのリクエストが成功すること" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
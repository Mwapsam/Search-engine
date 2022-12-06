require 'rails_helper'

RSpec.describe "UserSearches", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/user_search/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/user_search/show"
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns 200" do
      get "/"
      expect(response).to have_http_status(:ok)
    end
  end
end

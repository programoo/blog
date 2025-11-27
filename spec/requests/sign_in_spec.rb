require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user, scope: :user
  end

  it "allows access to feeds" do
    get "/feeds"
    expect(response).to have_http_status(:ok)
  end
end

require 'rails_helper'

RSpec.describe "Welcome", type: :request do

  it "allows access to home" do
    get "/"
    expect(response).to have_http_status(:ok)
  end

  it "allows access to feeds" do
    get "/feeds"
    expect(response).to have_http_status(:ok)
  end

  it "allows access to user sign in" do
    get "/users/sign_in"
    expect(response).to have_http_status(:ok)
  end

  it "allows access to user sign up" do
    get "/users/sign_up"
    expect(response).to have_http_status(:ok)
  end
end

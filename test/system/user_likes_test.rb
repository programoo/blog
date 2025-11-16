require "application_system_test_case"

class UserLikesTest < ApplicationSystemTestCase
  setup do
    @user_like = user_likes(:one)
  end

  test "visiting the index" do
    visit user_likes_url
    assert_selector "h1", text: "User likes"
  end

  test "should create user like" do
    visit user_likes_url
    click_on "New user like"

    fill_in "Movie", with: @user_like.movie_id
    fill_in "User", with: @user_like.user_id
    click_on "Create User like"

    assert_text "User like was successfully created"
    click_on "Back"
  end

  test "should update User like" do
    visit user_like_url(@user_like)
    click_on "Edit this user like", match: :first

    fill_in "Movie", with: @user_like.movie_id
    fill_in "User", with: @user_like.user_id
    click_on "Update User like"

    assert_text "User like was successfully updated"
    click_on "Back"
  end

  test "should destroy User like" do
    visit user_like_url(@user_like)
    click_on "Destroy this user like", match: :first

    assert_text "User like was successfully destroyed"
  end
end

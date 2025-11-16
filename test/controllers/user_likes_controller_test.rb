require "test_helper"

class UserLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_like = user_likes(:one)
  end

  test "should get index" do
    get user_likes_url
    assert_response :success
  end

  test "should get new" do
    get new_user_like_url
    assert_response :success
  end

  test "should create user_like" do
    assert_difference("UserLike.count") do
      post user_likes_url, params: { user_like: { movie_id: @user_like.movie_id, user_id: @user_like.user_id } }
    end

    assert_redirected_to user_like_url(UserLike.last)
  end

  test "should show user_like" do
    get user_like_url(@user_like)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_like_url(@user_like)
    assert_response :success
  end

  test "should update user_like" do
    patch user_like_url(@user_like), params: { user_like: { movie_id: @user_like.movie_id, user_id: @user_like.user_id } }
    assert_redirected_to user_like_url(@user_like)
  end

  test "should destroy user_like" do
    assert_difference("UserLike.count", -1) do
      delete user_like_url(@user_like)
    end

    assert_redirected_to user_likes_url
  end
end

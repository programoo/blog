require "test_helper"

class MovieMetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_metric = movie_metrics(:one)
  end

  test "should get index" do
    get movie_metrics_url
    assert_response :success
  end

  test "should get new" do
    get new_movie_metric_url
    assert_response :success
  end

  test "should create movie_metric" do
    assert_difference("MovieMetric.count") do
      post movie_metrics_url, params: { movie_metric: { comments_count: @movie_metric.comments_count, likes_count: @movie_metric.likes_count, movie_id: @movie_metric.movie_id, shares_count: @movie_metric.shares_count, views_count: @movie_metric.views_count } }
    end

    assert_redirected_to movie_metric_url(MovieMetric.last)
  end

  test "should show movie_metric" do
    get movie_metric_url(@movie_metric)
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_metric_url(@movie_metric)
    assert_response :success
  end

  test "should update movie_metric" do
    patch movie_metric_url(@movie_metric), params: { movie_metric: { comments_count: @movie_metric.comments_count, likes_count: @movie_metric.likes_count, movie_id: @movie_metric.movie_id, shares_count: @movie_metric.shares_count, views_count: @movie_metric.views_count } }
    assert_redirected_to movie_metric_url(@movie_metric)
  end

  test "should destroy movie_metric" do
    assert_difference("MovieMetric.count", -1) do
      delete movie_metric_url(@movie_metric)
    end

    assert_redirected_to movie_metrics_url
  end
end

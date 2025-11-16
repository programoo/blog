require "application_system_test_case"

class MovieMetricsTest < ApplicationSystemTestCase
  setup do
    @movie_metric = movie_metrics(:one)
  end

  test "visiting the index" do
    visit movie_metrics_url
    assert_selector "h1", text: "Movie metrics"
  end

  test "should create movie metric" do
    visit movie_metrics_url
    click_on "New movie metric"

    fill_in "Comments count", with: @movie_metric.comments_count
    fill_in "Likes count", with: @movie_metric.likes_count
    fill_in "Movie", with: @movie_metric.movie_id
    fill_in "Shares count", with: @movie_metric.shares_count
    fill_in "Views count", with: @movie_metric.views_count
    click_on "Create Movie metric"

    assert_text "Movie metric was successfully created"
    click_on "Back"
  end

  test "should update Movie metric" do
    visit movie_metric_url(@movie_metric)
    click_on "Edit this movie metric", match: :first

    fill_in "Comments count", with: @movie_metric.comments_count
    fill_in "Likes count", with: @movie_metric.likes_count
    fill_in "Movie", with: @movie_metric.movie_id
    fill_in "Shares count", with: @movie_metric.shares_count
    fill_in "Views count", with: @movie_metric.views_count
    click_on "Update Movie metric"

    assert_text "Movie metric was successfully updated"
    click_on "Back"
  end

  test "should destroy Movie metric" do
    visit movie_metric_url(@movie_metric)
    click_on "Destroy this movie metric", match: :first

    assert_text "Movie metric was successfully destroyed"
  end
end

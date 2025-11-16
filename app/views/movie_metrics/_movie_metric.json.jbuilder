json.extract! movie_metric, :id, :movie_id, :views_count, :likes_count, :comments_count, :shares_count, :created_at, :updated_at
json.url movie_metric_url(movie_metric, format: :json)

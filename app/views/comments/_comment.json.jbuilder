json.extract! comment, :id, :movie_id, :content, :user, :created_at, :updated_at
json.url comment_url(comment, format: :json)

class Movie < ApplicationRecord
    has_many_attached :images
    has_many :comments, dependent: :destroy
    has_one :movie_metric
    has_many :liking_users, through: :user_likes, source: :user
    has_rich_text :content
end

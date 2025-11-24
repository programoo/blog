class Movie < ApplicationRecord
    has_many_attached :images
    has_many :comments, dependent: :destroy
    has_one :movie_metric
    has_many :liking_users, through: :user_likes, source: :user
    has_rich_text :content

    has_many :ratings, dependent: :destroy

    def average_rating
        ratings.average(:value)&.round(2) || 0.0
    end

    def rating_for(user)
        return nil unless user
        ratings.find_by(user: user)&.value
    end
end

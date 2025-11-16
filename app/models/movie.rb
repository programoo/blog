class Movie < ApplicationRecord
    has_many_attached :images
    has_many :comments, dependent: :destroy
    has_one :movie_metric
end

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :movie_id, message: "has already rated this movie" }
end

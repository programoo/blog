class Movie < ApplicationRecord
    has_many_attached :images
    has_many :comments, dependent: :destroy
end

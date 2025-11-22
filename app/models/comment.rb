class Comment < ApplicationRecord
  belongs_to :movie, touch: true
  belongs_to :user, optional: true
  has_many :replies, dependent: :destroy
end

class Comment < ApplicationRecord
  belongs_to :movie, touch: true
  belongs_to :user, optional: true
  has_many :replies, dependent: :destroy
  has_rich_text :criticism
end

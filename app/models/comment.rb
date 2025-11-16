class Comment < ApplicationRecord
  belongs_to :movie, touch: true
  belongs_to :user, optional: true
end

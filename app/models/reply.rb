class Reply < ApplicationRecord
    belongs_to :comment, touch: true
    belongs_to :user, optional: true
    belongs_to :comment
end

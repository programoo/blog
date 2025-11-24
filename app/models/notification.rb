class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  after_create_commit -> { broadcast_prepend_later_to "notifications_#{user_id}" }
end

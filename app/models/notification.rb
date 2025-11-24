class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  after_create_commit :broadcast_notification

  def broadcast_notification
    # 1. Prepend new notification into the list
    broadcast_prepend_later_to "notifications_#{user_id}"

    # 2. Update the counter badge
    broadcast_update_later_to "notifications_#{user_id}",
      target: "notification-count",
      partial: "notifications/count",
      locals: { user: user }
  end
end

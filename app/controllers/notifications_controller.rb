class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user: current_user).order(created_at: :desc)
    @notifications.update_all(read: true)
  end
end

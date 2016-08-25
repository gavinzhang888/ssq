class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications_channel_#{notification.user_id}", notification: notification
  end
end

class AddLevelToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :level, :integer, default: 0
  end
end

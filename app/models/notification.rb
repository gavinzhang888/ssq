# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text(65535)
#  link       :string(255)
#  readed     :boolean          default(FALSE)
#  category   :integer
#  creator_id :integer
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :integer          default("info")
#

class Notification < ApplicationRecord
  enum level: { info: 0, success: 1, warning: 2, danger: 3}

  belongs_to :user, foreign_key: :user_id # 接收人
  belongs_to :creator, class_name: "User", foreign_key: :creator_id # 发送人
  include HistoryBase
  after_create_commit { NotificationBroadcastJob.perform_later self }

  def self.getUnreaded notifications
    n_hash = {
            category1:{content: notifications.where(category: 0).first.try(:content),
                        level: notifications.where(category: 0).first.try(:level),
                        count: notifications.where(category: 0).first.try(:category_count)
                        },
            category2:{content: notifications.where(category: 1).first.try(:content),
                        level: notifications.where(category: 1).first.try(:level),
                        count: notifications.where(category: 1).first.try(:category_count)
                        },
            category3:{content: notifications.where(category: 2).first.try(:content),
                        level: notifications.where(category: 2).first.try(:level),
                        count: notifications.where(category: 2).first.try(:category_count)
                        }
    }
    return n_hash
  end
end

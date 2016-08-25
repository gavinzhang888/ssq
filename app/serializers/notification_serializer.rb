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

class NotificationSerializer < BaseSerializer
  attributes :id, :user_id, :content, :link, :readed, :category, :level, :creator_id, :created_at, :readed_name

  def readed_name
    if object.readed
      I18n.t :"notification.readed_true"
    else
      I18n.t :"notification.readed_false"
    end
  end

  def creator
    object.creator.username rescue nil
  end

  def created_at
  	object.created_at.strftime "%Y-%m-%d %H:%M:%S" rescue nil
  end
end

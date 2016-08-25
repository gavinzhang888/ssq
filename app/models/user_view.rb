# == Schema Information
#
# Table name: user_views
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  list_type  :string(255)
#  name       :string(255)
#  is_default :boolean          default(FALSE)
#  detail     :text(65535)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserView < ApplicationRecord
  serialize :detail, Array
  validates_presence_of :name
  belongs_to :user, class_name: "::User", foreign_key: "user_id"

  DefaultViews = {
    "Api::V1::Client" => [:name, :category_id, :phone, :email, :address, :created_at],
    "Notification" => [:content, :link, :readed, :category, :level, :creator_id, :created_at]
  }


  def self.generate_default_view list_type
    self.new(name: (I18n.t :"page.static.default_view"), detail: DefaultViews[list_type], list_type: list_type)
  end
end

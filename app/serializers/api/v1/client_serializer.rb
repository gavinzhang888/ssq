# == Schema Information
#
# Table name: api_v1_clients
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  phone       :string(255)
#  email       :string(255)
#  address     :string(255)
#  remark      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  deleted_at  :datetime
#

class Api::V1::ClientSerializer < BaseSerializer
  attributes :id, :name, :category_id, :phone, :email, :address, :remark, :category, :creator_id

  # has_many :histories

  def category
  	object.category.name rescue nil
  end
end

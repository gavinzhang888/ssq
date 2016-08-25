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

class Api::V1::Client < ApplicationRecord
  validates_presence_of :name,:category_id
  belongs_to :creator, class_name: "::User", foreign_key: "creator_id"
  belongs_to :category, class_name: "Api::V1::Client::Category"

  # acts_as_paranoid
  include HistoryBase
end

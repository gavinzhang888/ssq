# == Schema Information
#
# Table name: api_v1_opportunities
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  client_id  :integer
#  amount     :decimal(12, 2)
#  remark     :string(255)
#  status_id  :integer
#  creator_id :integer
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Api::V1::Opportunity < ApplicationRecord
  validates_presence_of :name,:code
  belongs_to :creator, class_name: "::User", foreign_key: "creator_id"
  belongs_to :client, class_name: "Api::V1::Client", foreign_key: "client_id"

  # acts_as_paranoid
  include HistoryBase

  StatisticsColumns = ["amount"]
end

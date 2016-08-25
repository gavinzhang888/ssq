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

class Api::V1::OpportunitySerializer < BaseSerializer
  attributes :id, :code, :name, :client_id, :amount, :remark, :status_id, :creator_id, :client

  # has_many :histories

  def client
    object.client.name rescue ""
  end
end

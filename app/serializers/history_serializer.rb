# == Schema Information
#
# Table name: histories
#
#  id               :integer          not null, primary key
#  historyable_type :string(255)
#  historyable_id   :integer
#  user_id          :integer
#  operation        :string(255)
#  detail           :text(65535)
#  created_at       :datetime
#  updated_at       :datetime
#

class HistorySerializer < ActiveModel::Serializer
  attributes :id, :operator, :operation, :detail, :created_at

  def operator
	 object.operator.username rescue nil
  end

  def detail
    object.detail.split("--- !ruby")
  end

  def created_at
  	object.created_at.strftime "%Y-%m-%d<br/>%H:%M:%S" rescue nil
  end
end

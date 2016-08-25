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

class History < ActiveRecord::Base
  default_scope { includes(:operator) }

  belongs_to :historyable, polymorphic: true
  belongs_to :operator, class_name: "::User", foreign_key: "user_id"

  # 查找对应的历史记录
  # historyable: 历史记录所属model，historyable_id历史记录对应model对应id
  def self.search_by_historyable(historyable, historyable_id)
    current_class = historyable.constantize rescue nil
    return nil  unless current_class
    hisable = current_class.find(historyable_id)
    hisable.present? ? hisable.histories : nil
  end
end

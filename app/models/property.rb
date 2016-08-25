# == Schema Information
#
# Table name: properties
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sort_num   :integer
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Property < ActiveRecord::Base
  default_scope { order(:sort_num) }
  attr_accessor :editable
end

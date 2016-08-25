# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  detail     :text(65535)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  serialize :detail, Hash
  
  has_and_belongs_to_many :users
end

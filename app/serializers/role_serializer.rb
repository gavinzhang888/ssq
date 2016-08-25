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

class RoleSerializer < BaseSerializer
  attributes :id, :name, :detail
end

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

class UserViewSerializer < ActiveModel::Serializer
  attributes :id, :name, :list_type, :detail
end

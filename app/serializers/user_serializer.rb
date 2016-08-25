# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  username               :string(255)      default(""), not null
#  approved               :boolean          default(TRUE), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  locale                 :string(255)
#  theme                  :string(255)
#  boxed                  :boolean          default(FALSE)
#  collapsed              :boolean          default(FALSE)
#  floated                :boolean          default(FALSE)
#  hovered                :boolean          default(FALSE)
#  deleted_at             :datetime
#

class UserSerializer < BaseSerializer
  attributes :id, :username, :email, :approved, :locale, :theme, :boxed, :collapsed, :floated, :hovered

  # has_many :histories
end

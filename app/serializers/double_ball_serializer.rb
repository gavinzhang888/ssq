# == Schema Information
#
# Table name: double_balls
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  date       :datetime
#  red_1      :integer
#  red_2      :integer
#  red_3      :integer
#  red_4      :integer
#  red_5      :integer
#  red_6      :integer
#  blue       :integer
#  amount     :decimal(30, 2)   default(0.0)
#  decimal    :decimal(30, 2)   default(0.0)
#  grade_1    :integer          default(0)
#  amount_1   :decimal(30, 2)   default(0.0)
#  grade_2    :integer          default(0)
#  amount_2   :decimal(30, 2)   default(0.0)
#  grade_3    :integer          default(0)
#  amount_3   :decimal(30, 2)   default(0.0)
#  grade_4    :integer          default(0)
#  amount_4   :decimal(30, 2)   default(0.0)
#  grade_5    :integer          default(0)
#  amount_5   :decimal(30, 2)   default(0.0)
#  grade_6    :integer          default(0)
#  amount_6   :decimal(30, 2)   default(0.0)
#  creator_id :integer
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DoubleBallSerializer < BaseSerializer
  attributes :id, :number, :date, :red_1, :red_2, :red_3, :red_4, :red_5, :red_6, :blue, :amount, :grade_1,
    :amount_1, :grade_2, :amount_2, :grade_3, :amount_3, :grade_4, :amount_4, :grade_5, :amount_5, :grade_6, :amount_6
  def date
    object.date.strftime("%F") rescue nil
  end
end

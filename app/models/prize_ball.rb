# == Schema Information
#
# Table name: prize_balls
#
#  id          :integer          not null, primary key
#  number      :string(255)
#  date        :datetime
#  red_1       :integer
#  red_2       :integer
#  red_3       :integer
#  red_4       :integer
#  red_5       :integer
#  red_6       :integer
#  blue        :integer
#  all_count   :integer          default(0)
#  amount      :decimal(30, 2)   default(0.0)
#  grade_1     :integer          default(0)
#  amount_1    :decimal(30, 2)   default(0.0)
#  grade_2     :integer          default(0)
#  amount_2    :decimal(30, 2)   default(0.0)
#  grade_3     :integer          default(0)
#  amount_3    :decimal(30, 2)   default(0.0)
#  grade_4     :integer          default(0)
#  amount_4    :decimal(30, 2)   default(0.0)
#  grade_5     :integer          default(0)
#  amount_5    :decimal(30, 2)   default(0.0)
#  grade_6     :integer          default(0)
#  amount_6    :decimal(30, 2)   default(0.0)
#  odd         :integer          default(0)
#  prime       :integer          default(0)
#  red_total   :integer          default(0)
#  total       :integer          default(0)
#  week_number :integer
#  creator_id  :integer
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PrizeBall < ApplicationRecord
  belongs_to :creator, class_name: "::User", foreign_key: "creator_id"
  after_save :updat_info
  def updat_info
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
    sum = self.red_1 + self.red_2 + self.red_3 + self.red_4 + self.red_5 + self.red_6
    self.update_column(:red_total, sum) if self.red_total != sum
    sum += blue
    self.update_column(:total, sum) if self.total != sum
    x = self.date.wday
    self.update_column(:week_number, x) if self.week_number != x
    x = 0
    x += 1 if self.red_1 % 2 == 1
    x += 1 if self.red_2 % 2 == 1
    x += 1 if self.red_3 % 2 == 1
    x += 1 if self.red_4 % 2 == 1
    x += 1 if self.red_5 % 2 == 1
    x += 1 if self.red_6 % 2 == 1
    self.update_column(:odd, x) if self.odd != x
    x = 0
    x += 1 if primes.include?(self.red_1)
    x += 1 if primes.include?(self.red_2)
    x += 1 if primes.include?(self.red_3)
    x += 1 if primes.include?(self.red_4)
    x += 1 if primes.include?(self.red_5)
    x += 1 if primes.include?(self.red_6)
    self.update_column(:prime, x) if self.prime != x
  end
end

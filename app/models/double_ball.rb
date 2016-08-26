# == Schema Information
#
# Table name: double_balls
#
#  id          :integer          not null, primary key
#  number      :integer
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

class DoubleBall < ApplicationRecord
  belongs_to :creator, class_name: "::User", foreign_key: "creator_id"
# 2 3 5 7 11 13 17 19 23 29 31 质数
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
  def insert_data
    # DoubleBall.destroy_all
    (1..100).each do |index|
      ssq = auto_make()
      DoubleBall.create!(number: "2016#{index}", date: Time.new, red_1: ssq[0], red_2: ssq[1], red_3: ssq[2], red_4: ssq[3], red_5: ssq[4], red_6: ssq[5], blue: ssq[6])
    end
  end
  def auto_make
    arr_red = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]
    arr_blue = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    ssq = arr_red.sample(6).sort + arr_blue.sample(1)
    return ssq
  end
  def test1
    t1 = Time.new
    red = {}
    blue = {}
    (1..33).each do |index|
      red.store(index,0)
      blue.store(index,0) if index < 17
    end
    (1..1000000).each do |index|
      ssq = auto_make()
      red.store(ssq[0],(red.fetch(ssq[0])+1))
      red.store(ssq[1],(red.fetch(ssq[1])+1))
      red.store(ssq[2],(red.fetch(ssq[2])+1))
      red.store(ssq[3],(red.fetch(ssq[3])+1))
      red.store(ssq[4],(red.fetch(ssq[4])+1))
      red.store(ssq[5],(red.fetch(ssq[5])+1))
      blue.store(ssq[6],(blue.fetch(ssq[6])+1))
    end
    puts red,blue
    puts "用时",Time.new - t1
  end
  def test
    arr_red1 = arr_red2 = arr_red3 = arr_red4 = arr_red5 = arr_red6 = arr_red7 = arr_red8 = arr_red9 = arr_red10 = arr_red11 = arr_red12 = arr_red13 =
    arr_red14 = arr_red15 = arr_red16 = arr_red17 = arr_red18 = arr_red19 = arr_red20 = arr_red21 = arr_red22 = arr_red23 = arr_red24 = arr_red25 =
    arr_red26 = arr_red27 = arr_red28 = arr_red29 = arr_red30 = arr_red31 = arr_red32 = arr_red33 = arr_blue1 = arr_blue2 = arr_blue3 = arr_blue4 =
    arr_blue5 = arr_blue6 = arr_blue7 = arr_blue8 = arr_blue9 = arr_blue10 = arr_blue11 = arr_blue12 = arr_blue13 = arr_blue14 = arr_blue15 = arr_blue16 = 0
    (1..100000).each do |index|
      ssq = auto_make()
      arr_blue1 += 1 if ssq[6] == 1
      arr_blue2 += 1 if ssq[6] == 2
      arr_blue3 += 1 if ssq[6] == 3
      arr_blue4 += 1 if ssq[6] == 4
      arr_blue5 += 1 if ssq[6] == 5
      arr_blue6 += 1 if ssq[6] == 6
      arr_blue7 += 1 if ssq[6] == 7
      arr_blue8 += 1 if ssq[6] == 8
      arr_blue9 += 1 if ssq[6] == 9
      arr_blue10 += 1 if ssq[6] == 10
      arr_blue11 += 1 if ssq[6] == 11
      arr_blue12 += 1 if ssq[6] == 12
      arr_blue13 += 1 if ssq[6] == 13
      arr_blue14 += 1 if ssq[6] == 14
      arr_blue15 += 1 if ssq[6] == 15
      arr_blue16 += 1 if ssq[6] == 16
      ssq.pop
      arr_red1 += 1 if ssq.include?(1)
      arr_red2 += 1 if ssq.include?(2)
      arr_red3 += 1 if ssq.include?(3)
      arr_red4 += 1 if ssq.include?(4)
      arr_red5 += 1 if ssq.include?(5)
      arr_red6 += 1 if ssq.include?(6)
      arr_red7 += 1 if ssq.include?(7)
      arr_red8 += 1 if ssq.include?(8)
      arr_red9 += 1 if ssq.include?(9)
      arr_red10 += 1 if ssq.include?(10)
      arr_red11 += 1 if ssq.include?(11)
      arr_red12 += 1 if ssq.include?(12)
      arr_red13 += 1 if ssq.include?(13)
      arr_red14 += 1 if ssq.include?(14)
      arr_red15 += 1 if ssq.include?(15)
      arr_red16 += 1 if ssq.include?(16)
      arr_red17 += 1 if ssq.include?(17)
      arr_red18 += 1 if ssq.include?(18)
      arr_red19 += 1 if ssq.include?(19)
      arr_red20 += 1 if ssq.include?(20)
      arr_red21 += 1 if ssq.include?(21)
      arr_red22 += 1 if ssq.include?(22)
      arr_red23 += 1 if ssq.include?(23)
      arr_red24 += 1 if ssq.include?(24)
      arr_red25 += 1 if ssq.include?(25)
      arr_red26 += 1 if ssq.include?(26)
      arr_red27 += 1 if ssq.include?(27)
      arr_red28 += 1 if ssq.include?(28)
      arr_red29 += 1 if ssq.include?(29)
      arr_red30 += 1 if ssq.include?(30)
      arr_red31 += 1 if ssq.include?(31)
      arr_red32 += 1 if ssq.include?(32)
      arr_red33 += 1 if ssq.include?(33)
    end
    puts "红球1有#{arr_red1}个"
    puts "红球2有#{arr_red2}个"
    puts "红球3有#{arr_red3}个"
    puts "红球4有#{arr_red4}个"
    puts "红球5有#{arr_red5}个"
    puts "红球6有#{arr_red6}个"
    puts "红球7有#{arr_red7}个"
    puts "红球8有#{arr_red8}个"
    puts "红球9有#{arr_red9}个"
    puts "红球10有#{arr_red10}个"
    puts "红球11有#{arr_red11}个"
    puts "红球12有#{arr_red12}个"
    puts "红球13有#{arr_red13}个"
    puts "红球14有#{arr_red14}个"
    puts "红球15有#{arr_red15}个"
    puts "红球16有#{arr_red16}个"
    puts "红球17有#{arr_red17}个"
    puts "红球18有#{arr_red18}个"
    puts "红球19有#{arr_red19}个"
    puts "红球20有#{arr_red20}个"
    puts "红球21有#{arr_red21}个"
    puts "红球22有#{arr_red22}个"
    puts "红球23有#{arr_red23}个"
    puts "红球24有#{arr_red24}个"
    puts "红球25有#{arr_red25}个"
    puts "红球26有#{arr_red26}个"
    puts "红球27有#{arr_red27}个"
    puts "红球28有#{arr_red28}个"
    puts "红球29有#{arr_red29}个"
    puts "红球30有#{arr_red30}个"
    puts "红球31有#{arr_red31}个"
    puts "红球32有#{arr_red32}个"
    puts "红球33有#{arr_red33}个"
    puts "蓝球1有#{arr_blue1}个"
    puts "蓝球2有#{arr_blue2}个"
    puts "蓝球3有#{arr_blue3}个"
    puts "蓝球4有#{arr_blue4}个"
    puts "蓝球5有#{arr_blue5}个"
    puts "蓝球6有#{arr_blue6}个"
    puts "蓝球7有#{arr_blue7}个"
    puts "蓝球8有#{arr_blue8}个"
    puts "蓝球9有#{arr_blue9}个"
    puts "蓝球10有#{arr_blue10}个"
    puts "蓝球11有#{arr_blue11}个"
    puts "蓝球12有#{arr_blue12}个"
    puts "蓝球13有#{arr_blue13}个"
    puts "蓝球14有#{arr_blue14}个"
    puts "蓝球15有#{arr_blue15}个"
    puts "蓝球16有#{arr_blue16}个"
  end
  def more_test
    arr_red1 = 0
    arr_red2 = 0
    arr_red3 = 0
    arr_red4 = 0
    arr_red5 = 0
    arr_red6 = 0
    arr_red7 = 0
    arr_red8 = 0
    arr_red9 = 0
    arr_red10 = 0
    arr_red11 = 0
    arr_red12 = 0
    arr_red13 = 0
    arr_red14 = 0
    arr_red15 = 0
    arr_red16 = 0
    arr_red17 = 0
    arr_red18 = 0
    arr_red19 = 0
    arr_red20 = 0
    arr_red21 = 0
    arr_red22 = 0
    arr_red23 = 0
    arr_red24 = 0
    arr_red25 = 0
    arr_red26 = 0
    arr_red27 = 0
    arr_red28 = 0
    arr_red29 = 0
    arr_red30 = 0
    arr_red31 = 0
    arr_red32 = 0
    arr_red33 = 0
    arr_blue1 = 0
    arr_blue2 = 0
    arr_blue3 = 0
    arr_blue4 = 0
    arr_blue5 = 0
    arr_blue6 = 0
    arr_blue7 = 0
    arr_blue8 = 0
    arr_blue9 = 0
    arr_blue10 = 0
    arr_blue11 = 0
    arr_blue12 = 0
    arr_blue13 = 0
    arr_blue14 = 0
    arr_blue15 = 0
    arr_blue16 = 0
    (1..100000000).each do |index|
      ssq = auto_make()
      arr_red1 += 1 if ssq[0] == 1 || ssq[1] == 1 || ssq[2] == 1 || ssq[3] == 1 || ssq[4] == 1 || ssq[5] == 1
      arr_red2 += 1 if ssq[0] == 2 || ssq[1] == 2 || ssq[2] == 2 || ssq[3] == 2 || ssq[4] == 2 || ssq[5] == 2
      arr_red3 += 1 if ssq[0] == 3 || ssq[1] == 3 || ssq[2] == 3 || ssq[3] == 3 || ssq[4] == 3 || ssq[5] == 3
      arr_red4 += 1 if ssq[0] == 4 || ssq[1] == 4 || ssq[2] == 4 || ssq[3] == 4 || ssq[4] == 4 || ssq[5] == 4
      arr_red5 += 1 if ssq[0] == 5 || ssq[1] == 5 || ssq[2] == 5 || ssq[3] == 5 || ssq[4] == 5 || ssq[5] == 5
      arr_red6 += 1 if ssq[0] == 6 || ssq[1] == 6 || ssq[2] == 6 || ssq[3] == 6 || ssq[4] == 6 || ssq[5] == 6
      arr_red7 += 1 if ssq[0] == 7 || ssq[1] == 7 || ssq[2] == 7 || ssq[3] == 7 || ssq[4] == 7 || ssq[5] == 7
      arr_red8 += 1 if ssq[0] == 8 || ssq[1] == 8 || ssq[2] == 8 || ssq[3] == 8 || ssq[4] == 8 || ssq[5] == 8
      arr_red9 += 1 if ssq[0] == 9 || ssq[1] == 9 || ssq[2] == 9 || ssq[3] == 9 || ssq[4] == 9 || ssq[5] == 9
      arr_red10 += 1 if ssq[0] == 10 || ssq[1] == 10 || ssq[2] == 10 || ssq[3] == 10 || ssq[4] == 10 || ssq[5] == 10
      arr_red11 += 1 if ssq[0] == 11 || ssq[1] == 11 || ssq[2] == 11 || ssq[3] == 11 || ssq[4] == 11 || ssq[5] == 11
      arr_red12 += 1 if ssq[0] == 12 || ssq[1] == 12 || ssq[2] == 12 || ssq[3] == 12 || ssq[4] == 12 || ssq[5] == 12
      arr_red13 += 1 if ssq[0] == 13 || ssq[1] == 13 || ssq[2] == 13 || ssq[3] == 13 || ssq[4] == 13 || ssq[5] == 13
      arr_red14 += 1 if ssq[0] == 14 || ssq[1] == 14 || ssq[2] == 14 || ssq[3] == 14 || ssq[4] == 14 || ssq[5] == 14
      arr_red15 += 1 if ssq[0] == 15 || ssq[1] == 15 || ssq[2] == 15 || ssq[3] == 15 || ssq[4] == 15 || ssq[5] == 15
      arr_red16 += 1 if ssq[0] == 16 || ssq[1] == 16 || ssq[2] == 16 || ssq[3] == 16 || ssq[4] == 16 || ssq[5] == 16
      arr_red17 += 1 if ssq[0] == 17 || ssq[1] == 17 || ssq[2] == 17 || ssq[3] == 17 || ssq[4] == 17 || ssq[5] == 17
      arr_red18 += 1 if ssq[0] == 18 || ssq[1] == 18 || ssq[2] == 18 || ssq[3] == 18 || ssq[4] == 18 || ssq[5] == 18
      arr_red19 += 1 if ssq[0] == 19 || ssq[1] == 19 || ssq[2] == 19 || ssq[3] == 19 || ssq[4] == 19 || ssq[5] == 19
      arr_red20 += 1 if ssq[0] == 20 || ssq[1] == 20 || ssq[2] == 20 || ssq[3] == 20 || ssq[4] == 20 || ssq[5] == 20
      arr_red21 += 1 if ssq[0] == 21 || ssq[1] == 21 || ssq[2] == 21 || ssq[3] == 21 || ssq[4] == 21 || ssq[5] == 21
      arr_red22 += 1 if ssq[0] == 22 || ssq[1] == 22 || ssq[2] == 22 || ssq[3] == 22 || ssq[4] == 22 || ssq[5] == 22
      arr_red23 += 1 if ssq[0] == 23 || ssq[1] == 23 || ssq[2] == 23 || ssq[3] == 23 || ssq[4] == 23 || ssq[5] == 23
      arr_red24 += 1 if ssq[0] == 24 || ssq[1] == 24 || ssq[2] == 24 || ssq[3] == 24 || ssq[4] == 24 || ssq[5] == 24
      arr_red25 += 1 if ssq[0] == 25 || ssq[1] == 25 || ssq[2] == 25 || ssq[3] == 25 || ssq[4] == 25 || ssq[5] == 25
      arr_red26 += 1 if ssq[0] == 26 || ssq[1] == 26 || ssq[2] == 26 || ssq[3] == 26 || ssq[4] == 26 || ssq[5] == 26
      arr_red27 += 1 if ssq[0] == 27 || ssq[1] == 27 || ssq[2] == 27 || ssq[3] == 27 || ssq[4] == 27 || ssq[5] == 27
      arr_red28 += 1 if ssq[0] == 28 || ssq[1] == 28 || ssq[2] == 28 || ssq[3] == 28 || ssq[4] == 28 || ssq[5] == 28
      arr_red29 += 1 if ssq[0] == 29 || ssq[1] == 29 || ssq[2] == 29 || ssq[3] == 29 || ssq[4] == 29 || ssq[5] == 29
      arr_red30 += 1 if ssq[0] == 30 || ssq[1] == 30 || ssq[2] == 30 || ssq[3] == 30 || ssq[4] == 30 || ssq[5] == 30
      arr_red31 += 1 if ssq[0] == 31 || ssq[1] == 31 || ssq[2] == 31 || ssq[3] == 31 || ssq[4] == 31 || ssq[5] == 31
      arr_red32 += 1 if ssq[0] == 32 || ssq[1] == 32 || ssq[2] == 32 || ssq[3] == 32 || ssq[4] == 32 || ssq[5] == 32
      arr_red33 += 1 if ssq[0] == 33 || ssq[1] == 33 || ssq[2] == 33 || ssq[3] == 33 || ssq[4] == 33 || ssq[5] == 33
      arr_blue1 += 1 if ssq[6] == 1
      arr_blue2 += 1 if ssq[6] == 2
      arr_blue3 += 1 if ssq[6] == 3
      arr_blue4 += 1 if ssq[6] == 4
      arr_blue5 += 1 if ssq[6] == 5
      arr_blue6 += 1 if ssq[6] == 6
      arr_blue7 += 1 if ssq[6] == 7
      arr_blue8 += 1 if ssq[6] == 8
      arr_blue9 += 1 if ssq[6] == 9
      arr_blue10 += 1 if ssq[6] == 10
      arr_blue11 += 1 if ssq[6] == 11
      arr_blue12 += 1 if ssq[6] == 12
      arr_blue13 += 1 if ssq[6] == 13
      arr_blue14 += 1 if ssq[6] == 14
      arr_blue15 += 1 if ssq[6] == 15
      arr_blue16 += 1 if ssq[6] == 16
    end
    puts "红球1有#{arr_red1}个"
    puts "红球2有#{arr_red2}个"
    puts "红球3有#{arr_red3}个"
    puts "红球4有#{arr_red4}个"
    puts "红球5有#{arr_red5}个"
    puts "红球6有#{arr_red6}个"
    puts "红球7有#{arr_red7}个"
    puts "红球8有#{arr_red8}个"
    puts "红球9有#{arr_red9}个"
    puts "红球10有#{arr_red10}个"
    puts "红球11有#{arr_red11}个"
    puts "红球12有#{arr_red12}个"
    puts "红球13有#{arr_red13}个"
    puts "红球14有#{arr_red14}个"
    puts "红球15有#{arr_red15}个"
    puts "红球16有#{arr_red16}个"
    puts "红球17有#{arr_red17}个"
    puts "红球18有#{arr_red18}个"
    puts "红球19有#{arr_red19}个"
    puts "红球20有#{arr_red20}个"
    puts "红球21有#{arr_red21}个"
    puts "红球22有#{arr_red22}个"
    puts "红球23有#{arr_red23}个"
    puts "红球24有#{arr_red24}个"
    puts "红球25有#{arr_red25}个"
    puts "红球26有#{arr_red26}个"
    puts "红球27有#{arr_red27}个"
    puts "红球28有#{arr_red28}个"
    puts "红球29有#{arr_red29}个"
    puts "红球30有#{arr_red30}个"
    puts "红球31有#{arr_red31}个"
    puts "红球32有#{arr_red32}个"
    puts "红球33有#{arr_red33}个"
    puts "蓝球1有#{arr_blue1}个"
    puts "蓝球2有#{arr_blue2}个"
    puts "蓝球3有#{arr_blue3}个"
    puts "蓝球4有#{arr_blue4}个"
    puts "蓝球5有#{arr_blue5}个"
    puts "蓝球6有#{arr_blue6}个"
    puts "蓝球7有#{arr_blue7}个"
    puts "蓝球8有#{arr_blue8}个"
    puts "蓝球9有#{arr_blue9}个"
    puts "蓝球10有#{arr_blue10}个"
    puts "蓝球11有#{arr_blue11}个"
    puts "蓝球12有#{arr_blue12}个"
    puts "蓝球13有#{arr_blue13}个"
    puts "蓝球14有#{arr_blue14}个"
    puts "蓝球15有#{arr_blue15}个"
    puts "蓝球16有#{arr_blue16}个"
  end
end

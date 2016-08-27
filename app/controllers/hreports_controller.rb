class HreportsController < ApplicationController
  def index
    @prizes = DoubleBall.order("number asc").searching(current_user,params)

    @red_counts = {}#红球球号 出球次数hash
    @blue_counts = {}#蓝球球号 出球次数hash
    @red_order_counts = []#红球球号依次出球次数
    @blue_order_counts = []#蓝球球号依次出球次数
    (1..33).each do |index|
      @red_counts.store(index,0)
      @blue_counts.store(index,0)# if index < 17
    end
    @labels = []#期数、开奖日期、周
    @red_totals = []#红和
    @totals =[]#总和
    @odds = []#奇数
    @evens = []#偶数
    @primes = []#质数
    @composites = []#合数
    @blues = []#篮球
    @larges = []#大号次数
    @smalls = []#小号次数
    @red_firsts = []#红首
    @red_lasts = []#红尾
    @prizes.each do |prize|
      week_number = self.get_week_number(prize.week_number)
      @labels.push("#{prize.number}/#{prize.date.strftime("%F")}/#{week_number}")
      @red_totals.push(prize.red_total)
      @totals.push(prize.total)
      @odds.push(prize.odd)
      @evens.push(6 - prize.odd)
      @primes.push(prize.prime)
      @composites.push(6 - prize.prime)
      @blues.push(prize.blue)
      @larges.push(prize.large)
      @smalls.push(6 - prize.large)
      @red_firsts.push(prize.red_1)
      @red_lasts.push(prize.red_5)
      @red_counts.store(prize.red_1,(@red_counts.fetch(prize.red_1)+1))
      @red_counts.store(prize.red_2,(@red_counts.fetch(prize.red_2)+1))
      @red_counts.store(prize.red_3,(@red_counts.fetch(prize.red_3)+1))
      @red_counts.store(prize.red_4,(@red_counts.fetch(prize.red_4)+1))
      @red_counts.store(prize.red_5,(@red_counts.fetch(prize.red_5)+1))
      @red_counts.store(prize.red_6,(@red_counts.fetch(prize.red_6)+1))
      @blue_counts.store(prize.blue,(@blue_counts.fetch(prize.blue)+1))
    end
    (1..33).each do |index|
      @red_order_counts.push(@red_counts.fetch(index))
      @blue_order_counts.push(@blue_counts.fetch(index)) if index < 17
    end
    render json: @prizes, meta: { total: @prizes.total_entries, perpage: @prizes.per_page ,
      statistics_results: @prizes.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals,
      odds: @odds, primes: @primes, blues: @blues, evens: @evens, composites: @composites, larges: @larges, smalls: @smalls,
      red_firsts: @red_firsts, red_lasts: @red_lasts, red_order_counts: @red_order_counts, blue_order_counts: @blue_order_counts}
  end
  def get_week_number(week_number)
    case week_number
    when 0 then "周日"
    when 1 then "周一"
    when 2 then "周二"
    when 3 then "周三"
    when 4 then "周四"
    when 5 then "周五"
    when 6 then "周六"
    end
  end
end

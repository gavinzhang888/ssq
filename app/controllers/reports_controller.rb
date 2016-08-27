class ReportsController < ApplicationController
  def index
    @double_balls = DoubleBall.order("number asc").searching(current_user,params)

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
    @double_balls.each do |double_ball|
      week_number = self.get_week_number(double_ball.week_number)
      @labels.push("#{double_ball.number}/#{double_ball.date.strftime("%F")}/#{week_number}")
      @red_totals.push(double_ball.red_total)
      @totals.push(double_ball.total)
      @odds.push(double_ball.odd)
      @evens.push(6 - double_ball.odd)
      @primes.push(double_ball.prime)
      @composites.push(6 - double_ball.prime)
      @blues.push(double_ball.blue)
      @larges.push(double_ball.large)
      @smalls.push(6 - double_ball.large)
      @red_firsts.push(double_ball.red_1)
      @red_lasts.push(double_ball.red_5)
      @red_counts.store(double_ball.red_1,(@red_counts.fetch(double_ball.red_1)+1))
      @red_counts.store(double_ball.red_2,(@red_counts.fetch(double_ball.red_2)+1))
      @red_counts.store(double_ball.red_3,(@red_counts.fetch(double_ball.red_3)+1))
      @red_counts.store(double_ball.red_4,(@red_counts.fetch(double_ball.red_4)+1))
      @red_counts.store(double_ball.red_5,(@red_counts.fetch(double_ball.red_5)+1))
      @red_counts.store(double_ball.red_6,(@red_counts.fetch(double_ball.red_6)+1))
      @blue_counts.store(double_ball.blue,(@blue_counts.fetch(double_ball.blue)+1))
    end
    (1..33).each do |index|
      @red_order_counts.push(@red_counts.fetch(index))
      @blue_order_counts.push(@blue_counts.fetch(index)) if index < 17
    end
    render json: @double_balls, meta: { total: @double_balls.total_entries, perpage: @double_balls.per_page ,
      statistics_results: @double_balls.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals,
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

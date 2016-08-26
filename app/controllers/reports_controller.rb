class ReportsController < ApplicationController
  def index
    @double_balls = DoubleBall.order("number asc").searching(current_user,params)
    @labels = []
    @red_totals = []
    @totals =[]
    @odds = []
    @evens = []
    @primes = []
    @composites = []
    @blues = []
    @larges = []
    @smalls = []
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
    end
    render json: @double_balls, meta: { total: @double_balls.total_entries, perpage: @double_balls.per_page ,
      statistics_results: @double_balls.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals,
      odds: @odds, primes: @primes, blues: @blues, evens: @evens, composites: @composites, larges: @larges, smalls: @smalls}
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

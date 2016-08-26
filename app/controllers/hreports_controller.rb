class HreportsController < ApplicationController
  def index
    @prize_balls = PrizeBall.order("number asc").searching(current_user,params)
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
    @prize_balls.each do |prize_ball|
      week_number = self.get_week_number(prize_ball.week_number)
      @labels.push("#{prize_ball.number}/#{prize_ball.date.strftime("%F")}/#{week_number}")
      @red_totals.push(prize_ball.red_total)
      @totals.push(prize_ball.total)
      @odds.push(prize_ball.odd)
      @evens.push(6 - prize_ball.odd)
      @primes.push(prize_ball.prime)
      @composites.push(6 - prize_ball.prime)
      @blues.push(prize_ball.blue)
      @larges.push(prize_ball.large)
      @smalls.push(6 - prize_ball.large)
    end
    render json: @prize_balls, meta: { total: @prize_balls.total_entries, perpage: @prize_balls.per_page ,
      statistics_results: @prize_balls.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals,
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

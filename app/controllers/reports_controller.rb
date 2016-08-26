class ReportsController < ApplicationController
  def index
    @double_balls = DoubleBall.order("number asc").searching(current_user,params)
    @labels = []
    @red_totals = []
    @totals =[]
    @odds = []
    @primes = []
    @double_balls.each do |double_ball|
      @labels.push(double_ball.number)
      @red_totals.push(double_ball.red_total)
      @totals.push(double_ball.total)
      @odds.push(double_ball.odd)
      @primes.push(double_ball.prime)
    end
    # @labels = @double_balls.pluck(:number)
    # @red_totals = @double_balls.pluck(:red_total)
    # @totals = @double_balls.pluck(:total)
    render json: @double_balls, meta: { total: @double_balls.total_entries, perpage: @double_balls.per_page ,statistics_results: @double_balls.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals, odds: @odds, primes: @primes}
  end
end

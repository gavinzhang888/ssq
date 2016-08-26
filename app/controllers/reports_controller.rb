class ReportsController < ApplicationController
  def index
    @double_balls = DoubleBall.searching(current_user,params)
    @labels = @double_balls.pluck(:number)
    @red_totals = @double_balls.pluck(:red_total)
    @totals = @double_balls.pluck(:total)
    render json: @double_balls, meta: { total: @double_balls.total_entries, perpage: @double_balls.per_page ,statistics_results: @double_balls.statistics_results, labels: @labels, red_totals: @red_totals, totals: @totals}
  end
end

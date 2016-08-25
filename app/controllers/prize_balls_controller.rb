class PrizeBallsController < ApplicationController
  before_action :set_prize_ball, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "PrizeBall", :except => [:create]

  # GET /prize_balls
  # GET /prize_balls.json
  def index
    @prize_balls = PrizeBall.searching(current_user,params)

    render json: @prize_balls, meta: { total: @prize_balls.total_entries, perpage: @prize_balls.per_page ,statistics_results: @prize_balls.statistics_results}
  end

  # GET /prize_balls/1
  # GET /prize_balls/1.json
  def show
    render json: @prize_ball
  end

  # GET /prize_balls/new
  def new
    @prize_ball = PrizeBall.new
    render json: @prize_ball
  end

  # GET /prize_balls/1/edit
  def edit
  end

  # POST /prize_balls
  # POST /prize_balls.json
  def create
    @prize_ball = PrizeBall.new(prize_ball_params)
    @prize_ball.creator_id = current_user.id

    if @prize_ball.save
      render json: @prize_ball, meta: { errors: nil }
    else
      render json: @prize_ball, meta: { errors: @prize_ball.errors.full_messages }
    end
  end

  # PATCH/PUT /prize_balls/1
  # PATCH/PUT /prize_balls/1.json
  def update
    if @prize_ball.update(prize_ball_params)
      render json: @prize_ball, meta: { errors: nil }
    else
      render json: @prize_ball, meta: { errors: @prize_ball.errors.full_messages }
    end
  end

  # DELETE /prize_balls/1
  # DELETE /prize_balls/1.json
  def destroy
    render json: @prize_ball if @prize_ball.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prize_ball
      @prize_ball = PrizeBall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prize_ball_params
      params.require(:prize_ball).permit(:number, :date, :week_number, :red_1, :red_2, :red_3, :red_4, :red_5, :red_6, :blue,
        :amount, :grade_1, :amount_1, :grade_2, :amount_2, :grade_3, :amount_3, :grade_4, :amount_4, :grade_5, :amount_5,
        :grade_6, :amount_6, :odd, :prime, :red_total, :total, :all_count)
    end
end

class DoubleBallsController < ApplicationController
  before_action :set_double_ball, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "DoubleBall", :except => [:create]

  # GET /double_balls
  # GET /double_balls.json
  def index
    @double_balls = DoubleBall.searching(current_user,params)

    render json: @double_balls, meta: { total: @double_balls.total_entries, perpage: @double_balls.per_page ,statistics_results: @double_balls.statistics_results}
  end

  # GET /double_balls/1
  # GET /double_balls/1.json
  def show
    render json: @double_ball
  end

  # GET /double_balls/new
  def new
    @double_ball = DoubleBall.new
    render json: @double_ball
  end

  # GET /double_balls/1/edit
  def edit
  end

  # POST /double_balls
  # POST /double_balls.json
  def create
    @double_ball = DoubleBall.new(double_ball_params)
    @double_ball.creator_id = current_user.id

    if @double_ball.save
      render json: @double_ball, meta: { errors: nil }
    else
      render json: @double_ball, meta: { errors: @double_ball.errors.full_messages }
    end
  end

  # PATCH/PUT /double_balls/1
  # PATCH/PUT /double_balls/1.json
  def update
    if @double_ball.update(double_ball_params)
      render json: @double_ball, meta: { errors: nil }
    else
      render json: @double_ball, meta: { errors: @double_ball.errors.full_messages }
    end
  end

  # DELETE /double_balls/1
  # DELETE /double_balls/1.json
  def destroy
    render json: @double_ball if @double_ball.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_double_ball
      @double_ball = DoubleBall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def double_ball_params
      params.require(:double_ball).permit(:number, :date, :red_1, :red_2, :red_3, :red_4, :red_5, :red_6, :blue, :amount,
        :grade_1, :amount_1, :grade_2, :amount_2, :grade_3, :amount_3, :grade_4, :amount_4, :grade_5, :amount_5, :grade_6,
        :amount_6, :week_number, :odd, :prime, :red_total, :total, :all_count)
    end
end

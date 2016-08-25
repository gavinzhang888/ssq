class Api::V1::OpportunitiesController < ApplicationController
  before_action :set_api_v1_opportunity, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "Api::V1::Opportunity", :except => [:create]

  # GET /api/v1/opportunities
  # GET /api/v1/opportunities.json
  def index
    @api_v1_opportunities = Api::V1::Opportunity.searching(current_user,params,:creator)
    # @api_v1_opportunities = Api::V1::Opportunity.includes(:creator).all.order("id desc")
    # q = @api_v1_opportunities.search(params[:q])
    # @api_v1_opportunities = q.result(:distinct => true).paginate(:page => params[:page], :per_page => params[:per_page])
    render json: @api_v1_opportunities, meta: { total: @api_v1_opportunities.total_entries, perpage: @api_v1_opportunities.per_page ,statistics_results: @api_v1_opportunities.statistics_results}
  end

  # GET /api/v1/opportunities/1
  # GET /api/v1/opportunities/1.json
  def show
    render json: @api_v1_opportunity
  end

  # GET /api/v1/opportunities/new
  def new
    @api_v1_opportunity = Api::V1::Opportunity.new
    render json: @api_v1_opportunity
  end

  # GET /api/v1/opportunities/1/edit
  def edit
  end

  # POST /api/v1/opportunities
  # POST /api/v1/opportunities.json
  def create
    @api_v1_opportunity = Api::V1::Opportunity.new(api_v1_opportunity_params)
    @api_v1_opportunity.creator_id = current_user.id

    if @api_v1_opportunity.save
      render json: @api_v1_opportunity, meta: { errors: nil }
    else
      render json: @api_v1_opportunity, meta: { errors: @api_v1_opportunity.errors.full_messages }
    end
  end

  # PATCH/PUT /api/v1/opportunities/1
  # PATCH/PUT /api/v1/opportunities/1.json
  def update
    if @api_v1_opportunity.update(api_v1_opportunity_params)
      render json: @api_v1_opportunity, meta: { errors: nil }
    else
      render json: @api_v1_opportunity, meta: { errors: @api_v1_opportunity.errors.full_messages }
    end
  end

  # DELETE /api/v1/opportunities/1
  # DELETE /api/v1/opportunities/1.json
  def destroy
    render json: @api_v1_opportunity if @api_v1_opportunity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_opportunity
      @api_v1_opportunity = Api::V1::Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_opportunity_params
      params.require(:opportunity).permit(:code, :name, :client_id, :amount, :remark, :status_id, :creator_id)
    end
end

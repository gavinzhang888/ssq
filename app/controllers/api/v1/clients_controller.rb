class Api::V1::ClientsController < ApplicationController
  before_action :set_api_v1_client, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "Api::V1::Client", :except => [:create]

  # GET /api/v1/clients
  # GET /api/v1/clients.json
  def index
    @api_v1_clients = Api::V1::Client.searching(current_user,params)

    render json: @api_v1_clients, meta: { total: @api_v1_clients.total_entries, perpage: @api_v1_clients.per_page ,statistics_results: @api_v1_clients.statistics_results}
  end

  # GET /api/v1/clients/1
  # GET /api/v1/clients/1.json
  def show
    render json: @api_v1_client
  end

  # GET /api/v1/clients/new
  def new
    @api_v1_client = Api::V1::Client.new
    render json: @api_v1_client
  end

  # GET /api/v1/clients/1/edit
  def edit
  end

  # POST /api/v1/clients
  # POST /api/v1/clients.json
  def create
    @api_v1_client = Api::V1::Client.new(api_v1_client_params)
    @api_v1_client.creator_id = current_user.id

    if @api_v1_client.save
      render json: @api_v1_client, meta: { errors: nil }
    else
      render json: @api_v1_client, meta: { errors: @api_v1_client.errors.full_messages }
    end
  end

  # PATCH/PUT /api/v1/clients/1
  # PATCH/PUT /api/v1/clients/1.json
  def update
    if @api_v1_client.update(api_v1_client_params)
      render json: @api_v1_client, meta: { errors: nil }
    else
      render json: @api_v1_client, meta: { errors: @api_v1_client.errors.full_messages }
    end
  end

  # DELETE /api/v1/clients/1
  # DELETE /api/v1/clients/1.json
  def destroy
    render json: @api_v1_client if @api_v1_client.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_client
      @api_v1_client = Api::V1::Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_client_params
      params.require(:client).permit(:name, :category_id, :phone, :email, :address, :remark)
    end
end

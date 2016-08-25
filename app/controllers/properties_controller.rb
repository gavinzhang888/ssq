class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
    q = @properties.search(params[:q])
    @properties = q.result(:distinct => true)
    render json: @properties, meta: nil
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    render json: @properties
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    if @property.save
      render json: @property, meta: { errors: nil }
    else
      render json: @property, meta: { errors: @property.errors.full_messages }
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    if @property.update(property_params)
      render json: @property, meta: { errors: nil }
    else
      render json: @property, meta: { errors: @property.errors.full_messages }
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    render json: @property if @property.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :sort_num, :type)
    end
end

class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "Role", :except => [:create]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all.order("id desc")
    q = @roles.search(params[:q])
    @roles = q.result(:distinct => true).paginate(:page => params[:page], :per_page => params[:per_page])
    render json: @roles, meta: { total: @roles.total_entries, perpage: @roles.per_page }
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    render json: @role
  end

  # GET /roles/new
  def new
    @role = Role.new
    render json: @role
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    if @role.save
      render json: @role, meta: { errors: nil }
    else
      render json: @role, meta: { errors: @role.errors.full_messages }
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    if @role.update(role_params)
      render json: @role, meta: { errors: nil }
    else
      render json: @role, meta: { errors: @role.errors.full_messages }
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    render json: @role if @role.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit!
    end
end

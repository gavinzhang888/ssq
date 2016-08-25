class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :class => "User", :except => [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order("id desc")
    q = @users.search(params[:q])
    @users = q.result(:distinct => true).paginate(:page => params[:page], :per_page => params[:per_page])
    render json: @users, meta: { total: @users.total_entries, perpage: @users.per_page }
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
    render json: @user
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = "12345678" unless @user.password

    if @user.save
      render json: @user, meta: { errors: nil }
    else
      render json: @user, meta: { errors: @user.errors.full_messages }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render json: @user, meta: { errors: nil }
    else
      render json: @user, meta: { errors: @user.errors.full_messages }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    render json: @user if @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :approved, :locale, :theme, :boxed, :collapsed, :floated, :hovered, :password, :password_confirmation)
    end
end

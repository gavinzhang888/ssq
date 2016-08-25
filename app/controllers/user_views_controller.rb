class UserViewsController < ApplicationController
  def index
    @user_views = current_user.user_views.where(list_type: params[:list_type])
    # TODO 更新default
    # TODO 返回current_view
    @user_view = @user_views.where(is_default: true).first || UserView.generate_default_view(params[:list_type])
    render json: @user_views, meta: {current_view: @user_view, all_fields: @user_view.list_type.try(:constantize).try(:column_names)}
  end

  def new
    @user_view = UserView.new
    render json: @user_view
  end

  def show
    @user_view = UserView.find(params[:id])
    render json: @user_view
  end

  def create
    @user_view = UserView.new(user_view_params)
    @user_view.user_id = current_user.id
    if @user_view.save
      render json: @user_view, meta: { errors: nil }
    else
      render json: @user_view, meta: { errors: @user_view.errors.full_messages }
    end
  end

  def update
    UserView.update_all(is_default: false)

    @user_view = UserView.find(params[:id])
    @user_view.update!(user_view_params)
    if @user_view.is_default
      render json: @user_view, meta: { errors: nil }
    else
      render json: UserView.generate_default_view(@user_view.list_type), meta: { errors: @user_view.errors.full_messages }
    end
  end

  def destroy
    @user_view = UserView.find(params[:id])
    render json: @user_view if @user_view.destroy
  end

  private

    def user_view_params
      params.require(:user_view).permit(:name, :list_type, :is_default, detail: [])
    end

end

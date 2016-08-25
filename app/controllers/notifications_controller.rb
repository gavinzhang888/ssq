class NotificationsController < ApplicationController

  # GET /notifications
  # GET /notifications.json
  def index
    notifications = current_user.notifications.order("created_at DESC")
    @q = notifications.search(params[:q])
    @notifications = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => params[:per_page])
    render json: @notifications, meta: { total: @notifications.total_entries, perpage: @notifications.per_page}
    # @notifications = Notification.searching(current_user,params)
    # render json: @notifications, meta: { total: @notifications.total_entries,
    #                                             perpage: @notifications.per_page,
    #                                             statistics_results: @notifications.statistics_results}
  end

  def unreaded
    notifications = current_user.notifications.select(" * , count(category) AS category_count").where(readed: false).group(:category).order("created_at DESC")
    n_hash = Notification.getUnreaded(notifications)
    render json: [n_hash], meta: nil
  end

  def reading
    @notification = Notification.where(id: params[:id]).first
    if @notification.update(readed: true)
      render json: @notification, meta: { errors: nil }
    else
      render json: @notification, meta: { errors: @notifications.errors.full_messages }
    end
  end
end

class HistoriesController < ApplicationController
  load_and_authorize_resource :class => "History"

  def index
    @histories = History.search_by_historyable(params[:historyable], params[:historyable_id])
    render json: @histories
  end
end

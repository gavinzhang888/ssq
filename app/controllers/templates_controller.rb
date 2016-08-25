class TemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def properties
    params[:path] = "properties"
    session[:properties] = []
    case params[:t]
    when "client"
      session[:properties] = [{name: "category", cname: "客户类型", model: "Api::V1::Client::Category"}]
    end if params[:t]
  end

  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end
end

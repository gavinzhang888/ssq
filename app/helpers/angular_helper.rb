module AngularHelper
  #文本字符串搜索
  def search_text(option = {})
    html = p %{
      <select class="form-control" ng-model="search.#{option[:field]}.option" ng-init="search.#{option[:field]}.option = 'cont'">
        <option value="cont">包含</option>
        <option value="not_cont">不包含</option>
        <option value="eq">是</option>
        <option value="not_eq">不是</option>
        <option value="blank">为空</option>
        <option value="present">不为空</option>
      </select>
      <input type="text" class="form-control" ng-model="search.#{option[:field]}.value"/>
    }

    raw html
  end

  #数字搜索
  def search_number(option = {})
    html = p %{
      <select class="form-control" ng-model="search.#{option[:field]}.option" ng-init="search.#{option[:field]}.option = 'eq'">
        <option value="eq">等于</option>
        <option value="gt">大于</option>
        <option value="gteq">大于等于</option>
        <option value="lt">小于</option>
        <option value="lteq">小于等于</option>
      </select>
      <input type="text" class="form-control" ng-model="search.#{option[:field]}.value"/>
    }

    raw html
  end

  #日期搜索
  def search_date(option = {})
    html = p %{
      <select class="form-control" ng-model="search.#{option[:field]}.option" ng-init="search.#{option[:field]}.option = 'lgteq'">
        <option value="lgteq">是</option>
        <option value="lt">前于</option>
        <option value="gt">后于</option>
      </select>
      <input type="text" class="form-control" date-time-picker ng-model="search.#{option[:field]}.value"/>
    }

    raw html
  end

  #搜索按钮
  def search_button items
    html = p %{
      <button class="btn btn-success" ng-click="tableSearch('#{items}')">搜索</button>
      <button class="btn btn-default" data-toggle="collapse" data-target="#table-search">取消</button>
    }

    raw html
  end

  def grace_selection(params = {})
    params[:query] = params[:query] || ""
    columns = params[:columns].inject("") { |str,c| str << "<td>{{item." + c + "}}</td>" }
    html = p %{
      <div class="grace-selection input-width" ng-if="#{params[:class_name]}" ng-init="relationShipInit('#{params[:class_name]}', '#{params[:resource_name]}', '#{params[:relation_ship]}')" ng-controller="RelationShipsCtrl">
        <input class='form-control' type='hidden' ng-model='#{params[:ng_model]}.#{params[:relation_ship]}_id'>
        <div click-outside="hideOptions()" ng-click="getItemsData(#{params[:query]})" outside-if-not="selection-result, selection-actions, btn, input" class="selection-result">
          <a href="javascript:void(0);" ng-click="clearSelectedData()" ng-show="hadResult()"><i class="fa fa-times red"></i></a>
          <span>{{currentDataName || "未选择"}}</span>
          <a href="javascript:void(0);" class="pull-right" ng-show="!showSelectOptions"><i class="fa fa-caret-down gray"></i></a>
          <a href="javascript:void(0);" class="pull-right" ng-click="hideOptions()" ng-show="showSelectOptions"><i class="fa fa-caret-up gray"></i></a>
        </div>
        <div class="selection-options" ng-show="showSelectOptions">
          <div class="selection-actions">
            <div class="input-group input-group-sm mb1">
                <input type="text" class="form-control" ng-model="params.query">
                <span class="input-group-btn">
                <a href="javascript:void(0)" class="btn btn-default" ng-click="searchData(params)">搜索</a>
                </span>
            </div>

            <div class="clearfix" style="margin-top:8px;" ng-show="showSelectOptions">
              <span class="gray font12">共{{totalEntries}}个 {{params.page}}页/{{totalPages}}页</span>
              <a class="btn btn-xs btn-default pull-right" href="javascript:void(0)" ng-click="goPage(1)" ng-show="params.page < totalPages">下一页</a>
              <a class="btn btn-xs btn-default pull-right mr1" style="margin-right:5px;"  href="javascript:void(0)" ng-click="goPage(-1)" ng-show="params.page > 1">上一页</a>
            </div>
          </div>
          <div class="selection-table">
            <table class="table table-hover">
              <tbody>
                <tr ng-repeat="item in dataItems" ng-click="selectItem(item)">
                  #{columns}
                </tr>
              </tbody>
            </table>
	        </div>
	      </div>
		  </div>
    }

    raw html
  end
end

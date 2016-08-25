@app.controller "UserViewsCtrl",["$scope", "UserView", "Restangular", "$rootScope", "$location", "$routeParams", "$modal", ($scope, UserView, Restangular, $rootScope, $location, $routeParams, $modal) ->
  #全选字段
  $rootScope.select_all_fields = () ->
    if $rootScope.select_fields['0']
      angular.forEach $rootScope.model_columns, (item, key) ->
        $rootScope.select_fields[item] = true
    else
      $rootScope.select_fields =
        '0': false

  # index
  $rootScope.getCurrentUserViews = (list_type) ->
    $rootScope.select_fields =
      '0': false

    UserView.getList(
      list_type: list_type
    ).then (res) ->
      $rootScope.user_views = res
      $rootScope.current_view = res.meta.current_view
      $rootScope.model_columns = res.meta.all_fields
      angular.forEach $rootScope.model_columns, (item, key) ->
        $rootScope.select_fields[item] = false

  # 切换视图
  $rootScope.changeUserView = (select_view) ->
    if select_view
      $rootScope.current_view = select_view
      select_view.is_default = true
      select_view.put()
    else
      if $rootScope.user_views.length > 0
        $rootScope.user_views[0].is_default = false
        $rootScope.user_views[0].put().then (res) ->
          $rootScope.current_view = res

  #字段是否显示
  $rootScope.isShow = (filed) ->
    return $rootScope.current_view && $rootScope.current_view.detail.indexOf(filed) > -1

  #打开视图新建编辑弹窗
  $rootScope.openModal = (id) ->
    $rootScope.modalInstance = $modal.open(
      animation: true
      templateUrl: "templates/view_modal.html"
      controller: "RootCtrl"
    )
    $routeParams.id = id

  #关闭弹窗
  $rootScope.modalCancel = () ->
    $rootScope.modalInstance.close()

  #初始化字段选择弹窗
  $rootScope.initSelectField = () ->
    $rootScope.select_fields =
      '0': false
    angular.forEach $rootScope.current_view.detail, (item, key) ->
      $rootScope.select_fields[item] = true

  #获取当前视图
  $rootScope.getUserView = (id) ->
    if id
      UserView.one(id).get().then (res) ->
        $rootScope.user_view = res
    else
      Restangular.one('user_views').customGET("new").then (res) ->
        $rootScope.user_view = res
    return

  #删除当前视图
  $rootScope.deleteView = (item) ->
    swal
      title: "你确定要删除该视图吗?"
      type: "warning"
      showCancelButton: true
      confirmButtonColor: "#DD6B55"
      confirmButtonText: "删除"
      cancelButtonText: "取消"
      closeOnConfirm: true
    , ->
      angular.forEach $rootScope.user_views, (item, key) ->
        if item.id == $rootScope.current_view.id
          list_type = item.list_type
          item.remove().then ->
            $rootScope.user_views.splice $rootScope.user_views.indexOf(item), 1
            if $rootScope.user_views.length == 0
              UserView.getList({list_type: list_type}).then (res) ->
                $rootScope.current_view = res.meta.current_view
            else
              $rootScope.changeUserView()
            $scope.deleteSuccess()

  #保存当前视图
  $rootScope.submitUserView = (data) ->
    if data.id
      data.detail = $rootScope.getCurrentSelectArray()
      data.is_default = true
      data.put().then (res) ->
        unless res.meta.errors
          $rootScope.current_view = res
          $rootScope.modalInstance.close()
        else
          $rootScope.data_errors = res.meta.errors
        $scope.updateSuccess()
    else
      data.list_type = $rootScope.current_view.list_type
      data.detail = $rootScope.getCurrentSelectArray()

      UserView.post(data).then (res) ->
        list_type = res.list_type
        unless res.meta.errors
          UserView.getList(
            list_type: list_type
          ).then (res2) ->
            $rootScope.user_views = res2
            $rootScope.changeUserView(res)
            $rootScope.modalInstance.close()
        else
         $rootScope.data_errors = res.meta.errors
        $scope.createSuccess()

    return

  #获取当前选择字段到数组中
  $rootScope.getCurrentSelectArray = () ->
    detail = []
    angular.forEach $rootScope.select_fields, (item, key) ->
      if key != '0' && $rootScope.select_fields[key]
        detail.push(key)
    return detail

  #初始化视图表单
  $rootScope.userViewFormInit = () ->
    $rootScope.getUserView($routeParams.id)
]

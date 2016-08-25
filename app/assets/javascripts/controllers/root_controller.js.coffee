@app.controller "RootCtrl",["$scope","User", "Restangular", "$rootScope", "$location", "$routeParams", "$route", ($scope,User, Restangular, $rootScope, $location, $routeParams, $route) ->
  $scope.goBack = () ->
    window.history.back()

  $scope.refreshPage = () ->
    $route.reload()

  $scope.setPerpage = (num) ->
    $location.search(
      per_page: num
    )

  $scope.createSuccess = () ->
    $.notify "新建成功", status: "success", timeout: 2000

  $scope.updateSuccess = () ->
    $.notify "更新成功", status: "success", timeout: 2000

  $scope.deleteSuccess = () ->
    $.notify "删除成功", status: "success", timeout: 2000

  $scope.currentUser = (id) ->
    User.one(id).get().then (res) ->
      $scope.current_user = res
      $scope.setLanguage(res.locale)
      $scope.getToggleState()

  $scope.changeLanguage = (language) ->
    $scope.current_user.locale = language
    $scope.current_user.put().then (res) ->
      window.location.reload()

  $scope.changeTheme = (theme) ->
    $scope.current_user.theme = theme
    $scope.current_user.put()

  $scope.changeBoxed = () ->
    $scope.current_user.put()

  $scope.changeCollapsed = () ->
    $scope.current_user.put()

  $scope.changeFloated = () ->
    $scope.current_user.put()

  $scope.changeHovered = () ->
    $scope.current_user.put()

  $scope.getToggleState = () ->
    $scope.toggleStates = ""
    if $scope.current_user.boxed
      $scope.toggleStates += "layout-boxed"
    if $scope.current_user.collapsed
      $scope.toggleStates += " aside-collapsed"
    if $scope.current_user.floated
      $scope.toggleStates += " aside-float"
    if !$scope.current_user.hovered
      $scope.toggleStates += " layout-hover"
    return

  #Select
  $scope.select_datas =
    0: false

  $scope.select_items = (items) ->
    if $scope.select_datas[0]
      angular.forEach items, (item, key) ->
        $scope.select_datas[item.id] = true
    else
      $scope.select_datas =
        0: false

  $scope.select_item = (items) ->
    all_selected = true
    angular.forEach items, (item, key) ->
      if !$scope.select_datas[item.id]
        all_selected = false
    $scope.select_datas[0] = all_selected

  $scope.deleteAlert = (items,item) ->
    swal
      title: "你确定要删除这条数据吗?"
      type: "warning"
      showCancelButton: true
      confirmButtonColor: "#DD6B55"
      confirmButtonText: "删除"
      cancelButtonText: "取消"
      closeOnConfirm: true
    , ->
      item.remove().then ->
        items.splice items.indexOf(item), 1
        # swal "删除完成!", "", "success"
        $scope.deleteSuccess()

  $scope.deleteAllAlert = (items,item) ->
    selected_items = false
    angular.forEach items, (item, key) ->
      if $scope.select_datas[item.id]
        selected_items = true

    if selected_items
      swal
        title: "你确定要删除选择的数据吗?"
        type: "warning"
        showCancelButton: true
        confirmButtonColor: "#DD6B55"
        confirmButtonText: "删除"
        cancelButtonText: "取消"
        closeOnConfirm: true
      , ->
        angular.forEach items, (item, key) ->
          if $scope.select_datas[item.id]
            item.remove().then ->
              items.splice items.indexOf(item), 1
        $scope.select_datas[0] = false
        $scope.deleteSuccess()
    else
      swal("请至少选择一条数据！")

  $scope.setLanguage = (language) ->
    $scope.language = "中文"
    switch (language)
      when "en"
        $scope.language = "English"
        $scope.willPaginateConfig =
          previousLabel: "Previous"
          nextLabel: "Next"
      when "zh-CN"
        $scope.language = "中文"
        $scope.willPaginateConfig =
          previousLabel: "上一页"
          nextLabel: "下一页"
      else
        $scope.language = "中文"
        $scope.willPaginateConfig =
          previousLabel: "上一页"
          nextLabel: "下一页"


  #items:模块名复数，page:当前页
  $scope.tableSearch = (items, page) ->
    $scope.current_item = items

    if page
      condition =
        page: page
        per_page: $routeParams.per_page
    else
      condition = {}
      $rootScope.current_page = 1

    # 拼接检索条件
    angular.forEach $rootScope.search, (item, name) ->
      key = "q[" + name + "_" + item.option + "]"
      if item.option == 'blank' || item.option == 'present'
        condition[key] = true
      else if item.option == "lgteq" && item.value
        condition["q[" + name + "_lteq]"] = item.value + " 23:59:59"
        condition["q[" + name + "_gteq]"] = item.value + " 00:00:00"
      else if item.option == "s"
        condition["q[s]"] = item.value
      else
        condition[key] = item.value

    # 查询数据
    Restangular.all(items).getList(condition).then (res) ->
      eval("$scope." + items + " = res")
      eval("$scope." + items + ".statistics_results = res.meta.statistics_results")
      $scope.totalEntries = res.meta.total
      $scope.perPage = res.meta.perpage
      if res.meta.total > res.meta.perpage
        $scope.perpageEntries = res.meta.perpage
      else
        $scope.perpageEntries = res.meta.total
      $scope.willPaginateCollection =
        currentPage: $rootScope.current_page
        perPage: $scope.perPage
        totalEntries: $scope.totalEntries
        totalPages: Math.ceil(parseInt($scope.totalEntries)/$scope.perPage)
        offset: 0


  # 排序
  $scope.sortBy = (filed) ->
    return unless $scope.current_item && filed
    # 设置默认排序方式为降序
    $scope.currentSort = "DESC" unless $scope.currentSort

    if $scope.currentSortFiled && $scope.currentSortFiled == filed
      # 当前排序字段存在且不变，只是改变排序方式
      if $scope.currentSort == "DESC"
        $scope.currentSort = "ASC"
      else
        $scope.currentSort = "DESC"
    else
      # 当前排序字段不存在或者排序字段变更
      $scope.currentSortFiled = filed

    $rootScope.search.sortFiled = {}
    $rootScope.search.sortFiled.option = "s"
    $rootScope.search.sortFiled.value = $scope.currentSortFiled + " " + $scope.currentSort

    # 重新请求数据
    $scope.tableSearch($scope.current_item)

  # 获取历史记录
  $scope.getHistories = (historyable, historyable_id) ->
    unless ($scope.histories && $scope.last_historyable == historyable && $scope.last_historyable_id == historyable_id)
      $scope.last_historyable = historyable
      $scope.last_historyable_id = historyable_id
      Restangular.all("histories").getList(
        historyable: historyable
        historyable_id: historyable_id
        time: new Date()
      ).then (res) ->
        $scope.histories = res
      return
]

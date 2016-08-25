@app.controller "RelationShipsCtrl",["$scope", "Restangular", "$rootScope", "$location", "$routeParams", "$route", ($scope, Restangular, $rootScope, $location, $routeParams, $route) ->
  #getRelationShips
  $scope.getItemsData = (query) ->
    $scope.showSelectOptions = !$scope.showSelectOptions
    $scope.customQuery = query || "q[name_cont]"
    eval 'queryHash = {page: $scope.params.page,per_page: $scope.params.per_page,utf8: "true","q[s]": $scope.params.sort_by, "' + $scope.customQuery + '": $scope.params.query};'

    Restangular.all($scope.currentRes).getList(queryHash).then (res) ->
      $scope.dataItems = res
      $scope.totalEntries = res.meta.total
      $scope.perPage = res.meta.perpage
      $scope.totalPages = Math.ceil(parseInt($scope.totalEntries)/res.meta.perpage)

  $scope.goPage = (number) ->
    $scope.params.page = $scope.params.page + number
    $scope.getItemsData()
    $scope.showSelectOptions = true

  $scope.searchData = ->
    $scope.params.page = 1
    $scope.getItemsData($scope.customQuery)
    $scope.showSelectOptions = true

  $scope.selectItem = (item) ->
    $scope.setCurrentData(item.id, item.username || item.name || item.number)
    $scope.showSelectOptions = false

  $scope.setCurrentData = (id, name) ->
    eval "$scope." + $scope.currentClass + "." + $scope.currentRelation + "_id = id"
    $scope.setCurrentDataName(name)

  $scope.clearSelectedData = () ->
    eval "$scope." + $scope.currentClass + "." + $scope.currentRelation + "_id = null"
    $scope.setCurrentDataName("未选择")

  $scope.setCurrentDataName = (name) ->
    eval "$scope.currentDataName = name || $scope." + $scope.currentClass + "." +  $scope.currentRelation

  $scope.hideOptions = () ->
    $scope.showSelectOptions = false

  $scope.hadResult = ->
    result = true
    switch $scope.currentDataName
      when undefined
        result = false
      when ""
        result = false
      when "未选择"
        result = false
    return result

  $scope.relationShipInit = (currentClass, currentRes, currentRelation) ->
    $scope.currentClass = currentClass
    $scope.currentRes = currentRes
    $scope.currentRelation = currentRelation
    $scope.params =
      page: 1
    $scope.setCurrentDataName()
    $scope.setCurrentData($routeParams.data_id, $routeParams.data_name) if $routeParams.data_class == $scope.currentRelation
]

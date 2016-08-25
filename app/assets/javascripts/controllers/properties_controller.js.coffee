@app.controller "PropertiesCtrl",["$scope", "Property", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, Property, Restangular, $rootScope, $location, $routeParams) ->
  $scope.getProperties =(property) ->
    Property.getList(
      "q[type_cont]": property.model
    ).then (res) ->
      $scope[property.name + "_properties"] = res

  $scope.submitProperty = (data,name) ->
    if data.id
      data.put()
      data.editable = false
    else
      Property.post(data).then (res) ->
        eval("$scope." + name + "_properties" + ".unshift(res)")
        data.name = ""

    return

  # 拖动属性
  $scope.sortableOptions = 
    stop: (e, ui) ->
      # 获取拖动排序后的属性数组
      type = ui.item.sortable.model.type
      cn = type.split("::").slice(-1).toString().toLowerCase()
      current_properties = $scope[cn + "_properties"]
      angular.forEach current_properties, (property , index) ->
        property.sort_num = index
        property.put()

  $scope.editProperty = (data) ->
    data.editable = true

  $scope.setUp = (resource) ->
    angular.forEach resource, (value, key) ->
      $scope.getProperties(value)
]

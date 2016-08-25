@app.controller "ClientsCtrl",["$scope", "Client", "Restangular", "$rootScope", "$location", "$routeParams", "$filter", ($scope, Client, Restangular, $rootScope, $location, $routeParams, $filter) ->
  #index
  $scope.getData = () ->
    $rootScope.search = {}
    $scope.tableSearch("clients")

  $scope.getPage = (page) ->
    $rootScope.current_page = page
    $scope.tableSearch("clients", page)

  #properties
  $scope.getCategories = () ->
    Restangular.all("properties").getList("q[type_cont]":"Api::V1::Client::Category").then (res) ->
      $scope.categories = res

    return

  #show
  $scope.getClient = (id) ->
    if id
      Client.one(id).get().then (res) ->
        $scope.client = res
        $scope.getCategories()
    else
      Restangular.one('clients').customGET("new").then (res) ->
        $scope.client = res
    return

  $scope.clientInit = () ->
    $scope.getClient($routeParams.id)

  #form
  $scope.clientFormInit = () ->
    $scope.getCategories()
    $scope.getClient($routeParams.id)

  $scope.updateClient = () ->
    $scope.client.put().then (res) ->
      if res.meta.errors
        return res.meta.errors[0]
      else
        $scope.client.category = $filter("filter")($scope.categories,id: res.category_id)[0].name
        return

  $scope.submitClient = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $scope.goBack()
          $scope.updateSuccess()
        else
         $scope.data_errors = res.meta.errors
    else
      Client.post(data).then (res) ->
        unless res.meta.errors
          $scope.goBack()
          $scope.createSuccess()
        else
         $scope.data_errors = res.meta.errors

    return
]

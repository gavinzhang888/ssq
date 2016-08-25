@app.controller "DoubleBallsCtrl",["$scope", "DoubleBall", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, DoubleBall, Restangular, $rootScope, $location, $routeParams) ->
  # index
  $scope.getData = () ->
    $rootScope.search = {}
    $scope.tableSearch("double_balls")

  $scope.getPage = (page) ->
    $rootScope.current_page = page
    $scope.tableSearch("double_balls", page)

  # show
  $scope.getDoubleBall = (id) ->
    if id
      DoubleBall.one(id).get().then (res) ->
        $scope.double_ball = res
    else
      Restangular.one('double_balls').customGET("new").then (res) ->
        $scope.double_ball = res
    return

  $scope.double_ballInit = () ->
    $scope.getDoubleBall($routeParams.id)

  #form
  $scope.double_ballFormInit = () ->
    $scope.getDoubleBall($routeParams.id)

  $scope.submitDoubleBall = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/double_balls")
        else
          $scope.data_errors = res.meta.errors
    else
      DoubleBall.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/double_balls")
        else
          $scope.data_errors = res.meta.errors

    return
]

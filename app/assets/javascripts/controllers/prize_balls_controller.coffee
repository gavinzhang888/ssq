@app.controller "PrizeBallsCtrl",["$scope", "PrizeBall", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, PrizeBall, Restangular, $rootScope, $location, $routeParams) ->
  # index
  $scope.getData = () ->
    $rootScope.search = {}
    $scope.tableSearch("prize_balls")

  $scope.getPage = (page) ->
    $rootScope.current_page = page
    $scope.tableSearch("prize_balls", page)

  # show
  $scope.getPrizeBall = (id) ->
    if id
      PrizeBall.one(id).get().then (res) ->
        $scope.prize_ball = res
    else
      Restangular.one('prize_balls').customGET("new").then (res) ->
        $scope.prize_ball = res
    return

  $scope.prize_ballInit = () ->
    $scope.getPrizeBall($routeParams.id)

  #form
  $scope.prize_ballFormInit = () ->
    $scope.getPrizeBall($routeParams.id)

  $scope.submitPrizeBall = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/prize_balls")
        else
          $scope.data_errors = res.meta.errors
    else
      PrizeBall.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/prize_balls")
        else
          $scope.data_errors = res.meta.errors

    return
]

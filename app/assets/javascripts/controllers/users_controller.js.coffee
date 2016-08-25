@app.controller "UsersCtrl",["$scope", "User", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, User, Restangular, $rootScope, $location, $routeParams) ->
  #delete
  $scope.destroyUser = (item) ->
    item.remove().then ->
      $scope.users.splice $scope.users.indexOf(item), 1

  #index
  $scope.getData = () ->
    User.getList(
      page: $routeParams.page,
      per_page: $routeParams.per_page,
      utf8: "true",
      "q[username_cont]": $routeParams.query,
      "q[created_at_gteq]": $routeParams.started_at,
      "q[created_at_lteq]": $routeParams.ended_at
    ).then (res) ->
      $scope.users = res
      $scope.totalEntries = res.meta.total
      $scope.perPage = res.meta.perpage
      $scope.query = $routeParams.query
      $scope.started_at = $routeParams.started_at
      $scope.ended_at = $routeParams.ended_at
      $scope.willPaginateCollection =
        currentPage: parseInt($routeParams.page) || 1
        perPage: $scope.perPage
        totalEntries: $scope.totalEntries
        totalPages: Math.ceil(parseInt($scope.totalEntries)/$scope.perPage)
        offset: 0

  $scope.getPage = (page) ->
    $location.path("/users").search
      page: page
      per_page: $routeParams.per_page
      query: $routeParams.query
      started_at: $routeParams.started_at
      ended_at: $routeParams.ended_at

  $scope.search = (query, started_at, ended_at) ->
    $location.path("/users").search
      query: query
      started_at: started_at
      ended_at: ended_at
  #show
  $scope.getUser = (id) ->
    if id
      User.one(id).get().then (res) ->
        $scope.user = res
    else
      Restangular.one('users').customGET("new").then (res) ->
        $scope.user = res
    return

  $scope.userInit = () ->
    $scope.getUser($routeParams.id)

  #form
  $scope.userFormInit = () ->
    $scope.getUser($routeParams.id)

  $scope.submitUser = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/users")
        else
         $scope.data_errors = res.meta.errors
    else
      User.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/users")
        else
         $scope.data_errors = res.meta.errors

    return
]

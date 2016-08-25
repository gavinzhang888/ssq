@app.controller "RolesCtrl",["$scope", "Role", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, Role, Restangular, $rootScope, $location, $routeParams) ->
  #delete
  $scope.destroyRole = (item) ->
    item.remove().then ->
      $scope.roles.splice $scope.roles.indexOf(item), 1

  #index
  $scope.getData = () ->
    Role.getList(
      page: $routeParams.page,
      per_page: $routeParams.per_page,
      utf8: "true",
      "q[name_cont]": $routeParams.query,
      "q[created_at_gteq]": $routeParams.started_at,
      "q[created_at_lteq]": $routeParams.ended_at
    ).then (res) ->
      $scope.roles = res
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
    $location.path("/roles").search
      page: page
      per_page: $routeParams.per_page
      query: $routeParams.query
      started_at: $routeParams.started_at
      ended_at: $routeParams.ended_at

  $scope.search = (query, started_at, ended_at) ->
    $location.path("/roles").search
      query: query
      started_at: started_at
      ended_at: ended_at
  #show
  $scope.getRole = (id) ->
    $scope.rolenames = ["客户","用户"]
    if id
      Role.one(id).get().then (res) ->
        $scope.role = res
    else
      Restangular.one('roles').customGET("new").then (res) ->
        $scope.role = res
    return

  $scope.roleInit = () ->
    $scope.getRole($routeParams.id)

  $scope.checkAll = (rolenames) ->
    angular.forEach rolenames, (rolename, key) ->
      eval 'hash = {"' + rolename + '":{"create":true,"read":true,"readall":true,"readgroup":true,"readlower":true,"edit":true,"editall":true,"editgroup":true,"editeditlower":true,"destroy":true,"destroyall":true,"destroygroup":true,"destroylower":true, "histories":true}}'
      angular.extend($scope.role.detail, hash)

  #form
  $scope.roleFormInit = () ->
    $scope.getRole($routeParams.id)

  $scope.submitRole = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/roles")
        else
         $scope.data_errors = res.meta.errors
    else
      Role.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/roles")
        else
         $scope.data_errors = res.meta.errors

    return
]

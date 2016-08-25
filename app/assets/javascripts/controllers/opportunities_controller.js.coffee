@app.controller "OpportunitiesCtrl",["$scope", "Opportunity", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, Opportunity, Restangular, $rootScope, $location, $routeParams) ->
  #index
  $scope.getData = () ->
    $rootScope.search = {}
    $scope.tableSearch("opportunities")

  $scope.getPage = (page) ->
    $rootScope.current_page = page
    $scope.tableSearch("opportunities", page)

  #show
  $scope.getOpportunity = (id) ->
    if id
      Opportunity.one(id).get().then (res) ->
        $scope.opportunity = res
    else
      Restangular.one('opportunities').customGET("new").then (res) ->
        $scope.opportunity = res
    return

  $scope.opportunityInit = () ->
    $scope.getOpportunity($routeParams.id)

  #form
  $scope.opportunityFormInit = () ->
    $scope.getOpportunity($routeParams.id)

  $scope.submitOpportunity = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/opportunities")
        else
         $scope.data_errors = res.meta.errors
    else
      Opportunity.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/opportunities")
        else
         $scope.data_errors = res.meta.errors

    return
]

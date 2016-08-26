@app.controller "ReportsCtrl",["$scope", "DoubleBall", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, DoubleBall, Restangular, $rootScope, $location, $routeParams) ->

  # $scope.setPerpage = (num) ->
  #   $location.search(
  #     per_page: num
  #   )

  # index
  $scope.paginate = {}
  $scope.searchReportData = ( options = {}) ->
    $scope.search = {}
    condition = {}
    if options['page']
      condition =
        page: options['page']
        per_page: options['per_page']

    Restangular.all("reports").getList(condition).then (res) ->
      $scope.double_balls = res
      $scope.labels = res.meta["labels"]
      $scope.series = ['红和', '总和']
      $scope.series2 = ['奇数', '质数']
      $scope.data = [
        res.meta["red_totals"],
        res.meta["totals"]
      ]
      $scope.data2 = [
        res.meta["odds"],
        res.meta["primes"]
      ]
      if res.meta
        $scope.paginate.per_page = res.meta.perpage
        $scope.paginate.total_entries = res.meta.total
        $scope.willPaginateCollection =
          currentPage: $scope.paginate.current_page || 1
          perPage: $scope.paginate.per_page
          totalEntries: $scope.paginate.total_entries
          totalPages: Math.ceil(parseInt($scope.paginate.total_entries)/$scope.paginate.per_page)
          offset: 0
      else
        $scope.paginate.total_entries = 0

  $scope.getData = () ->
    $scope.searchReportData()

  $scope.getPage = (page, per_page) ->
    $scope.paginate.current_page =  page
    $scope.searchReportData({page: page, per_page: per_page || $scope.paginate.per_page})
]

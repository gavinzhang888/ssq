@app.controller "ReportsCtrl",["$scope", "DoubleBall", "Restangular", "$rootScope", "$location", "$routeParams", ($scope, DoubleBall, Restangular, $rootScope, $location, $routeParams) ->

  # index
  $scope.paginate = {}
  $scope.searchReportData = ( options = {}) ->
    $scope.all_red_numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]
    $scope.all_blue_numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
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
      $scope.series2 = ['奇数', '偶数']
      $scope.series3 = ['质数', '合数']
      $scope.series4 = ['奇数', '质数']
      $scope.series5 = ['篮球', '篮球']
      $scope.series6 = ['大号', '小号']
      $scope.series7 = ['奇数', '合数']
      $scope.series8 = ['奇数', '大号']
      $scope.series9 = ['奇数', '小号']
      $scope.series10 = ['质数', '大号']
      $scope.series11 = ['质数', '小号']
      $scope.series12 = ['合数', '大号']
      $scope.series13 = ['合数', '小号']
      $scope.series14 = ['偶数', '质数']
      $scope.series15 = ['偶数', '合数']
      $scope.series16 = ['偶数', '大号']
      $scope.series17 = ['偶数', '小号']
      $scope.series18 = ['红首', '红尾']
      $scope.labels2 = $scope.all_red_numbers
      $scope.series19 = ['红', '蓝']
      $scope.data = [
        res.meta["red_totals"],
        res.meta["totals"]
      ]
      $scope.data2 = [
        res.meta["odds"],
        res.meta["evens"]
      ]
      $scope.data3 = [
        res.meta["primes"],
        res.meta["composites"]
      ]
      $scope.data4 = [
        res.meta["odds"],
        res.meta["primes"]
      ]
      $scope.data5 = [
        res.meta["blues"],
        res.meta["blues"]
      ]
      $scope.data6 = [
        res.meta["larges"],
        res.meta["smalls"]
      ]
      $scope.data7 = [
        res.meta["odds"],
        res.meta["composites"]
      ]
      $scope.data8 = [
        res.meta["odds"],
        res.meta["larges"]
      ]
      $scope.data9 = [
        res.meta["odds"],
        res.meta["smalls"]
      ]
      $scope.data10 = [
        res.meta["primes"],
        res.meta["larges"]
      ]
      $scope.data11 = [
        res.meta["primes"],
        res.meta["smalls"]
      ]
      $scope.data12 = [
        res.meta["composites"],
        res.meta["larges"]
      ]
      $scope.data13 = [
        res.meta["composites"],
        res.meta["smalls"]
      ]
      $scope.data14 = [
        res.meta["evens"],
        res.meta["primes"]
      ]
      $scope.data15 = [
        res.meta["evens"],
        res.meta["composites"]
      ]
      $scope.data16 = [
        res.meta["evens"],
        res.meta["larges"]
      ]
      $scope.data17 = [
        res.meta["evens"],
        res.meta["smalls"]
      ]
      $scope.data18 = [
        res.meta["red_firsts"],
        res.meta["red_lasts"]
      ]
      $scope.data19 = [
        res.meta["red_order_counts"],
        res.meta["blue_order_counts"]
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

  # 排序
  $scope.sortBy = (filed) ->
    return unless $scope.double_balls && filed
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
    $scope.searchReportData($scope.double_balls)

  $scope.getPage = (page, per_page) ->
    $scope.paginate.current_page =  page
    $scope.searchReportData({page: page, per_page: per_page || $scope.paginate.per_page})
]

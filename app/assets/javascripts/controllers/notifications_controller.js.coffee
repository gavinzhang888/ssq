@app.controller "NotificationsCtrl",["$scope", "Notification", "Restangular", "$rootScope", "$location", "$routeParams","$filter", ($scope, Notification, Restangular, $rootScope, $location, $routeParams,$filter) ->
  # index
  $scope.getData = () ->
    $rootScope.search = {}
    if $routeParams.category
      $rootScope.search.category = {}
      $rootScope.search.category.option = "eq"
      $rootScope.search.category.value = $routeParams.category
    if $routeParams.readed
      $rootScope.search.readed = {}
      $rootScope.search.readed.option = "eq"
      $rootScope.search.readed.value = $routeParams.readed
    $scope.tableSearch("notifications")

  $scope.getPage = (page) ->
    $rootScope.current_page = page
    $scope.tableSearch("notifications", page)

  # show
  $scope.getNotification = (id) ->
    if id
      Notification.one(id).get().then (res) ->
        $scope.notification = res
    else
      Restangular.one('notifications').customGET("new").then (res) ->
        $scope.notification = res
    return

  $scope.notificationInit = () ->
    $scope.getNotification($routeParams.id)

  #form
  $scope.notificationFormInit = () ->
    $scope.getNotification($routeParams.id)

  $scope.submitNotification = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/notifications")
        else
          $scope.data_errors = res.meta.errors
    else
      Notification.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/notifications")
        else
          $scope.data_errors = res.meta.errors

    return

  $scope.unReadedCount = () ->
    Restangular.all("notifications").customGETLIST("unreaded").then (res) ->
      $scope.n_hash = res[0]
      $scope.notificationsCount = $scope.n_hash.category1.count + $scope.n_hash.category2.count + $scope.n_hash.category3.count
    return

  # notification count,category count
  $scope.getNotificationCategory = (category, readed) ->
    console.log(readed)
    if readed == false && category != undefined
      $location.url("/notifications?category=" + category + "&readed=" + readed)
    else if readed == undefined && category != undefined
      $location.url("/notifications?category=" + category)
    else
      $location.url("/notifications?readed=false")

  # content link
  $scope.contentLink = (notification)->
    if notification.readed
      $location.path(notification.link) if notification.link
    else
      Restangular.one('notifications').customGET("reading",id: notification.id).then (res) ->
        unless res.meta.errors
          $scope.unReadedCount()
          $location.path(notification.link) if notification.link
        else
          $scope.data_errors = res.meta.errors
]

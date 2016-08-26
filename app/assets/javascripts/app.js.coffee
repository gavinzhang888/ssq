@app = angular.module("hydra", [
  "ngResource",
  "ngRoute",
  "ngAnimate",
  "willPaginate",
  "angular-click-outside",
  "restangular",
  "ui.bootstrap",
  "xeditable",
  "ui.sortable",
  "chart.js"
])

@app.config(['$httpProvider', ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
])

@app.config [
  "$locationProvider"
  ($locationProvider) ->
    $locationProvider.html5Mode true
]

@app.config(['RestangularProvider', (RestangularProvider) ->
  RestangularProvider.setBaseUrl('/api/v1/')
  RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
    extractedData = undefined
    # .. to look for getList operations
    if operation is "getList" or "get" or "customGETLIST"
      # .. and handle the data and meta data
      extractedData = data.body
      extractedData.meta = data.meta
    else
      extractedData = data
    extractedData
])

# Declare factory
@app.factory 'Notification', ['Restangular', (Restangular) ->
  Restangular.service 'notifications'
]
@app.factory 'Client', ['Restangular', (Restangular) ->
  Restangular.service 'clients'
]
@app.factory 'ProjectInfo', ['Restangular', (Restangular) ->
  Restangular.service 'project_infos'
]
@app.factory 'DoubleBall', ['Restangular', (Restangular) ->
  Restangular.service 'double_balls'
]
@app.factory 'PrizeBall', ['Restangular', (Restangular) ->
  Restangular.service 'prize_balls'
]
@app.factory 'Opportunity', ['Restangular', (Restangular) ->
  Restangular.service 'opportunities'
]
@app.factory 'User', ['Restangular', (Restangular) ->
  Restangular.service 'users'
]
@app.factory 'Role', ['Restangular', (Restangular) ->
  Restangular.service 'roles'
]
@app.factory 'Property', ['Restangular', (Restangular) ->
  Restangular.service 'properties'
]
@app.factory 'UserView', ['Restangular', (Restangular) ->
  Restangular.service 'user_views'
]

@app.directive "ngReallyClick", [->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "click", ->
      message = attrs.ngReallyMessage
      scope.$apply attrs.ngReallyClick  if message and confirm(message)
      return

    return
]

@app.directive "dateTimePicker", [->
  restrict: "A"
  require: 'ngModel'
  link: (scope, element, attributes, ngModel) ->
    element.datetimepicker
      format: 'YYYY-MM-DD'
      locale: 'zh-cn'
      useCurrent: false
    element.on "dp.change", (e) ->
      ngModel.$setViewValue(element.context.value)
    return
]

@app.run ["editableOptions", "editableThemes", (editableOptions, editableThemes) ->
  editableThemes.bs3.inputClass = 'input-sm'
  editableThemes.bs3.buttonsClass = 'btn-sm'
  editableOptions.theme = 'bs3'
]

@app.directive "sortListHtml", [->
  restrict: "A"
  templateUrl: '/templates/custom/sort_list.html'
  controller: [
    '$scope', ($scope) ->
        $scope.filed =
          name: ""
          value: ""
        $scope.setFiled = (name, value) ->
          $scope.filed =
            name: name
            value: value
    ]
  scope: true
  link: (scope, element, attributes) ->
    scope.setFiled(attributes.filed, attributes.filedName)
    element.addClass("sort-th")
    element.on 'click', (event) ->
      scope.sortBy(attributes.filed)
    return
]

# @app.directive "select2", [->
#   restrict: "A"
#   link: (scope, element) ->
#     element.select2(
#       theme: 'bootstrap'
#     )
#     return
# ]

@app.filter "unsafe", [
  "$sce"
  ($sce) ->
    return (val) ->
      $sce.trustAsHtml val
]

@app.filter "customCurrency",["$filter", ($filter) ->
  return (amount, currencySymbol) ->
    currency = $filter('currency')
    if amount < 0
      return currency(amount, currencySymbol).replace("(", "-").replace(")", "")
    return currency(amount, currencySymbol)
]
#打印
@app.directive 'printDiv', ->
  {
    restrict: 'A'
    link: (scope, element, attrs) ->

      PrintElem = (elem) ->
        PrintWithIframe $(elem).html()
        return

      PrintWithIframe = (data) ->
        if $('iframe#printf').size() == 0
          $('html').append '<iframe id="printf" name="printf"></iframe>'
          mywindow = window.frames['printf']
          mywindow.document.write '<html><head><title></title><link href="http://7rylrz.com1.z0.glb.clouddn.com/print.css" rel="stylesheet">' + '</head><body><div>' + data + '</div></body></html>'
          $(mywindow.document).ready ->
            mywindow.print()
            setTimeout (->
              $('iframe#printf').remove()
              return
            ), 2000
            return
        true

      element.bind 'click', (evt) ->
        evt.preventDefault()
        PrintElem attrs.printDiv
        return
      return

  }

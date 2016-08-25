@app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/clients', templateUrl: '/templates/clients/index.html', controller: 'ClientsCtrl'
  $routeProvider.when '/clients/:id/edit', templateUrl: '/templates/clients/edit.html', controller: 'ClientsCtrl'
  $routeProvider.when '/clients/new', templateUrl: '/templates/clients/new.html', controller: 'ClientsCtrl'
  $routeProvider.when '/clients/:id', templateUrl: '/templates/clients/show.html', controller: 'ClientsCtrl'

  $routeProvider.when '/opportunities', templateUrl: '/templates/opportunities/index.html', controller: 'OpportunitiesCtrl'
  $routeProvider.when '/opportunities/:id/edit', templateUrl: '/templates/opportunities/edit.html', controller: 'OpportunitiesCtrl'
  $routeProvider.when '/opportunities/new', templateUrl: '/templates/opportunities/new.html', controller: 'OpportunitiesCtrl'
  $routeProvider.when '/opportunities/:id', templateUrl: '/templates/opportunities/show.html', controller: 'OpportunitiesCtrl'

  $routeProvider.when '/users', templateUrl: '/templates/users/index.html', controller: 'UsersCtrl'
  $routeProvider.when '/users/:id/edit', templateUrl: '/templates/users/edit.html', controller: 'UsersCtrl'
  $routeProvider.when '/users/new', templateUrl: '/templates/users/new.html', controller: 'UsersCtrl'
  $routeProvider.when '/users/:id', templateUrl: '/templates/users/show.html', controller: 'UsersCtrl'

  $routeProvider.when '/roles', templateUrl: '/templates/roles/index.html', controller: 'RolesCtrl'
  $routeProvider.when '/roles/:id/edit', templateUrl: '/templates/roles/edit.html', controller: 'RolesCtrl'
  $routeProvider.when '/roles/new', templateUrl: '/templates/roles/new.html', controller: 'RolesCtrl'
  $routeProvider.when '/roles/:id', templateUrl: '/templates/roles/show.html', controller: 'RolesCtrl'

  $routeProvider.when '/double_balls', templateUrl: '/templates/double_balls/index.html', controller: 'DoubleBallsCtrl'
  $routeProvider.when '/double_balls/:id/edit', templateUrl: '/templates/double_balls/edit.html', controller: 'DoubleBallsCtrl'
  $routeProvider.when '/double_balls/new', templateUrl: '/templates/double_balls/new.html', controller: 'DoubleBallsCtrl'
  $routeProvider.when '/double_balls/:id', templateUrl: '/templates/double_balls/show.html', controller: 'DoubleBallsCtrl'

  $routeProvider.when '/properties', templateUrl: '/templates/properties/index.html', controller: 'PropertiesCtrl'

  $routeProvider.when '/notifications', templateUrl: '/templates/notifications/index.html', controller: 'NotificationsCtrl'
])

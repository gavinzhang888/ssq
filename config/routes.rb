Rails.application.routes.draw do

  resources :double_balls, defaults: { format: 'json' }, path: 'api/v1/double_balls'
  resources :reports, defaults: { format: 'json' }, path: 'api/v1/reports' do
    collection do
      get 'line', defaults: { format: 'json' }
    end
  end

  # get 'notifications/index'

  mount ActionCable.server => '/cable'

  devise_for :users, :skip => [:registrations], :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  namespace :api do
    namespace :v1 do
      resources :clients
      resources :opportunities
    end
  end

  resources :user_views, except: [:edit], defaults: { format: 'json' }, path: 'api/v1/user_views'
  resources :histories, only: :index, defaults: { format: 'json' }, path: 'api/v1/histories'
  resources :users, defaults: { format: 'json' }, path: 'api/v1/users'
  resources :properties, defaults: { format: 'json' }, path: 'api/v1/properties'
  resources :roles, defaults: { format: 'json' }, path: 'api/v1/roles'
  resources :notifications, defaults: { format: 'json' }, path: 'api/v1/notifications' do
    collection do
     get 'unreaded'
     get 'reading'
   end
 end

  root 'templates#index'

  controllers = /(clients)|(double_balls)|(reports)|(opportunities)|(users)|(roles)|(notifications)/
  match ":path" => 'templates#index', via: :get, constraints: {
    path: controllers
  }
  match ":path/:id/edit" => 'templates#index', via: :get, constraints: {
    path: controllers
  }

  match ":path/new" => 'templates#index', via: :get, constraints: {
    path: controllers
  }
  match ":path/:id" => 'templates#index', via: :get, constraints: {
    path: controllers
  }

  # match "clients" => 'templates#index', as: :ng_clients, via: :get
  # match "clients/:id/edit" => 'templates#index', as: :ng_edit_client, via: :get
  # match "clients/new" => 'templates#index', as: :ng_new_client, via: :get
  # match "clients/:id" => 'templates#index', as: :ng_show_client, via: :get
  #
  # match "opportunities" => 'templates#index', as: :ng_opportunities, via: :get
  # match "opportunities/:id/edit" => 'templates#index', as: :ng_edit_opportunity, via: :get
  # match "opportunities/new" => 'templates#index', as: :ng_new_opportunity, via: :get
  # match "opportunities/:id" => 'templates#index', as: :ng_show_opportunity, via: :get
  #
  # match "users" => 'templates#index', as: :ng_users, via: :get
  # match "users/:id/edit" => 'templates#index', as: :ng_edit_user, via: :get
  # match "users/new" => 'templates#index', as: :ng_new_user, via: :get
  # match "users/:id" => 'templates#index', as: :ng_show_user, via: :get
  #
  # match "roles" => 'templates#index', as: :ng_roles, via: :get
  # match "roles/:id/edit" => 'templates#index', as: :ng_edit_role, via: :get
  # match "roles/new" => 'templates#index', as: :ng_new_role, via: :get
  # match "roles/:id" => 'templates#index', as: :ng_show_role, via: :get

  match "properties" => "templates#properties", as: :ng_properties, via: :get
  match "notifications" => "templates#notifications", as: :ng_notifications, via: :get

  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }
  # defaults to dashboard
  # root :to => redirect('/dashboard/dashboard_v1')

  # view routes
  get '/widgets' => 'widgets#index'
  get '/documentation' => 'documentation#index'

  get 'dashboard/dashboard_v1'
  get 'dashboard/dashboard_v2'
  get 'dashboard/dashboard_v3'
  get 'dashboard/dashboard_h'
  get 'elements/button'
  get 'elements/notification'
  get 'elements/spinner'
  get 'elements/animation'
  get 'elements/dropdown'
  get 'elements/nestable'
  get 'elements/sortable'
  get 'elements/panel'
  get 'elements/portlet'
  get 'elements/grid'
  get 'elements/gridmasonry'
  get 'elements/typography'
  get 'elements/fonticons'
  get 'elements/weathericons'
  get 'elements/colors'
  get 'elements/buttons'
  get 'elements/notifications'
  get 'elements/carousel'
  get 'elements/tour'
  get 'elements/sweetalert'
  get 'forms/standard'
  get 'forms/extended'
  get 'forms/validation'
  get 'forms/wizard'
  get 'forms/upload'
  get 'forms/xeditable'
  get 'forms/imgcrop'
  get 'multilevel/level1'
  get 'multilevel/level3'
  get 'charts/flot'
  get 'charts/radial'
  get 'charts/chartjs'
  get 'charts/chartist'
  get 'charts/morris'
  get 'charts/rickshaw'
  get 'tables/standard'
  get 'tables/extended'
  get 'tables/datatable'
  get 'tables/jqgrid'
  get 'maps/google'
  get 'maps/vector'
  get 'extras/mailbox'
  get 'extras/timeline'
  get 'extras/calendar'
  get 'extras/invoice'
  get 'extras/search'
  get 'extras/todo'
  get 'extras/profile'
  get 'blog/blog'
  get 'blog/blog_post'
  get 'blog/blog_articles'
  get 'blog/blog_article_view'
  get 'ecommerce/ecommerce_orders'
  get 'ecommerce/ecommerce_order_view'
  get 'ecommerce/ecommerce_products'
  get 'ecommerce/ecommerce_product_view'
  get 'forum/forum_categories'
  get 'forum/forum_topics'
  get 'forum/forum_discussion'
  get 'pages/login'
  get 'pages/register'
  get 'pages/recover'
  get 'pages/lock'
  get 'pages/template'
  get 'pages/notfound'

  # api routes
  get '/api/documentation' => 'api#documentation'
  get '/api/datatable' => 'api#datatable'
  get '/api/jqgrid' => 'api#jqgrid'
  get '/api/jqgridtree' => 'api#jqgridtree'
  get '/api/i18n/:locale' => 'api#i18n'
  post '/api/xeditable' => 'api#xeditable'
  get '/api/xeditable-groups' => 'api#xeditablegroups'

  # the rest goes to root
  get '*path' => redirect('/')
end

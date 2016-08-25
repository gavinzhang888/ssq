require 'exception_notification/rails'
#require 'exception_notification/sidekiq'

ExceptionNotification.configure do |config|
  # Ignore additional exception types.
  # ActiveRecord::RecordNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
  # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

  # Adds a condition to decide when an exception must be ignored or not.
  # The ignore_if method can be invoked multiple times to add extra conditions.
  config.ignore_if do |exception, options|
    not Rails.env.production?
  end

  # Notifiers =================================================================

  # Email notifier sends notifications by email.
  mail_mangers = %w{ fanwei@netfarmer.com.cn tanxiaobin@netfarmer.com.cn }
  smtp_settings = {
      :address => "smtp.mxhichina.com",
      :domain => "smtp.mxhichina.com",
      :port => 25,
      :authentication => :login,
      :user_name => "support@netfarmer.com.cn",
      :password => "Net4006690619",
  }
  config.add_notifier :email, {
    :email_prefix => "[旺田云服务] ",
    :sender_address => %{ "Application Error" <support@netfarmer.com.cn> },
    :exception_recipients => mail_mangers,
    :delivery_method => :smtp,
    :smtp_settings => smtp_settings
  }

  # Campfire notifier sends notifications to your Campfire room. Requires 'tinder' gem.
  # config.add_notifier :campfire, {
  #   :subdomain => 'my_subdomain',
  #   :token => 'my_token',
  #   :room_name => 'my_room'
  # }

  # HipChat notifier sends notifications to your HipChat room. Requires 'hipchat' gem.
  # config.add_notifier :hipchat, {
  #   :api_token => 'my_token',
  #   :room_name => 'my_room'
  # }

  # Webhook notifier sends notifications over HTTP protocol. Requires 'httparty' gem.
  # config.add_notifier :webhook, {
  #   :url => 'http://example.com:5555/hubot/path',
  #   :http_method => :post
  # }

end

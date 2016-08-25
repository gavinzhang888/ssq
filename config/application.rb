require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module R5suite
  class Application < Rails::Application
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config','locales','chinese', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config','locales','english', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:"zh-CN", :en]
    config.i18n.default_locale = :"zh-CN"
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.encoding = "utf-8"

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  false
      g.tests           false
      g.helper          false
      g.stylesheets     true
      g.javascripts     true
      g.javascript_engine :angular_js
    end

    # setup bower components folder for lookup
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets' ,'fonts')
    # fonts
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    # images
    config.assets.precompile << /\.(?:png|jpg)$/
    # precompile vendor assets
    config.assets.precompile += %w( base.js )
    config.assets.precompile += %w( base.css )
    # precompile themes
    config.assets.precompile += ['angle/themes/theme-a.css',
                                 'angle/themes/theme-b.css',
                                 'angle/themes/theme-c.css',
                                 'angle/themes/theme-d.css',
                                 'angle/themes/theme-e.css',
                                 'angle/themes/theme-f.css',
                                 'angle/themes/theme-g.css',
                                 'angle/themes/theme-h.css'
                                ]
    # Controller assets
    config.assets.precompile += [
                                 # Scripts
                                 'charts.js',
                                 'dashboard.js',
                                 'documentation.js',
                                 'elements.js',
                                 'extras.js',
                                 'forms.js',
                                 'maps.js',
                                 'multilevel.js',
                                 'pages.js',
                                 'tables.js',
                                 'widgets.js',
                                 'blog.js',
                                 'ecommerce.js',
                                 'forum.js',
                                 # Stylesheets
                                 'charts.css',
                                 'dashboard.css',
                                 'documentation.css',
                                 'elements.css',
                                 'extras.css',
                                 'forms.css',
                                 'maps.css',
                                 'multilevel.css',
                                 'pages.css',
                                 'tables.css',
                                 'widgets.css',
                                 'blog.css',
                                 'ecommerce.css',
                                 'forum.css'
                                ]

  end
end

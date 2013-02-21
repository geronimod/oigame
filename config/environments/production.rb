Oigame::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  #config.assets.compile = false
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  config.assets.initialize_on_precompile = false

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  config.cache_store = :redis_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  # http://stackoverflow.com/questions/9346822/rails-3-1-why-is-rails-admin-causing-rake-assetprecompile-to-fail
  config.assets.precompile += ['rails_admin/rails_admin.css', 'rails_admin/rails_admin.js']

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  
  # Para Devise
  config.action_mailer.default_url_options = { :host => 'oiga.me', :locale => I18n.locale }
  config.to_prepare { Devise::SessionsController.force_ssl }
  config.to_prepare { Devise::RegistrationsController.force_ssl }
  config.to_prepare { Devise::PasswordsController.force_ssl }

  # Configuración para ActionMailer
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => false,
    :address => 'pulsar.oiga.me'
  }
  
  # para que rule resque mailer
  config.action_mailer.perform_deliveries = true
  
  # Para notificar excepciones
  #config.middleware.use ExceptionNotifier,
  #  :email_prefix => "[oiga.me exception] ",
  #  :sender_address => %{"notifier" <notifier@oiga.me>},
  #  :exception_recipients => %w{debug@alabs.es}

  # SSL en todo el sitio
  config.force_ssl = true

  # instancia de redis
  config.cache_store = :redis_store, { :host => '127.0.0.1', :port => 6379 }
  config.sesion_store = :redis_store, { :host => '127.0.0.1', :port => 6379 }
end

Airbrake.configure do |config|
  config.api_key = 'c6626f26039ab33d1b509b50bde13659'
  config.host    = 'err.oiga.me'
  config.port    = 443
  config.secure  = config.port == 443
end

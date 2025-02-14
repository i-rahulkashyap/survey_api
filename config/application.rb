require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require "dotenv/load"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SurveyApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.autoload_paths << Rails.root.join('app/lib')
    # Add middleware for cookies and sessions:
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_my_auth_app_session'
    
    # Use OmniAuth middleware AFTER sessions are set up.
    config.middleware.use OmniAuth::Builder do
      provider :google_oauth2,
               ENV['GOOGLE_CLIENT_ID'],  
               ENV['GOOGLE_CLIENT_SECRET'],  
               {
                 scope: 'userinfo.email,userinfo.profile',
                 prompt: 'select_account'
               }
    end

    OmniAuth.config.allowed_request_methods = [:post, :get]


    # Configure CORS to allow requests from your frontend
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'  # Replace '*' with your frontend domain in production
        resource '*',
                 headers: :any,
                 methods: [:get, :post, :patch, :put, :options, :delete]
      end
    end
  end
end
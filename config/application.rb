require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # tell the I18n library where to find your translations
    I18n.load_path += Dir[Rails.root.join("lib", "locale", "*.{rb,yml}")]
    I18n.available_locales = [:en, :vi]

    # set default locale to something other than :en
    I18n.default_locale = :vi
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
end
end

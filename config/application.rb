require_relative "boot"
require "csv"
require "rails/all"
Bundler.require(*Rails.groups)

module HMS
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.logger = Logger.new(STDOUT)
  end
end

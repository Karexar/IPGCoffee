require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ipgcoffee
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #DEPRECATION WARNING: Leaving `ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer`
    #set to false is deprecated. SQLite databases have used 't' and 'f' to serialize
    #boolean values and must have old data converted to 1 and 0 (its native boolean
    #serialization) before setting this flag to true. Conversion can be accomplished
    #by setting up a rake task which runs

    #  ExampleModel.where("boolean_column = 't'").update_all(boolean_column: 1)
    #  ExampleModel.where("boolean_column = 'f'").update_all(boolean_column: 0)

    #for all models and all boolean columns, after which the flag must be set to
    #true by adding the following to your application.rb file:

    Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true

    # force HTTPS on all environments
    #config.force_ssl = true
  end
end

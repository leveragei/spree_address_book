# Run Coverage report
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/dummy'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib'
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'rspec/rails'
require 'rspec/active_model/mocks'
require 'factory_girl_rails'
require 'database_cleaner'
require 'ffaker'
require 'capybara/rails'
require 'capybara/poltergeist' #PhantomJS


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories and other useful helpers defined in spree_core.
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/factories'
require 'spree/testing_support/preferences'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/flash'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/order_walkthrough'
require 'spree/testing_support/caching'

require 'paperclip/matchers'

# Requires factories defined in lib/spree_advanced_reporting/factories.rb
require 'spree_address_book/factories'

require "spec_helper"
ActiveRecord::Migration.maintain_test_schema!

FactoryGirl.find_definitions

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { debug: false, js_errors: true, cookies: true , phantomjs_logger: File.open(File::NULL, "w"), timeout: 200})
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|

  config.before(:each) do |example|
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation, {
          except: ['spree_countries', 'spree_zones', 'spree_zone_members', 'spree_states', 'spree_roles']
      }
    else
      DatabaseCleaner.strategy = :transaction
    end

    # TODO: Find out why open_transactions ever gets below 0
    # See issue #3428
    if ActiveRecord::Base.connection.open_transactions < 0
      ActiveRecord::Base.connection.increment_open_transactions
    end
    DatabaseCleaner.start
    reset_spree_preferences

    # not sure exactly what is happening here, but i think it takes an iteration for the country data to load
    Spree::Config[:default_country_id] = Spree::Country.find_by_iso3('USA').id if Spree::Country.count > 0
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, type: :feature) do
    missing_translations = page.body.scan(/translation missing: #{I18n.locale}\.(.*?)[\s<\"&]/)
    if missing_translations.any?
      #binding.pry
      puts "Found missing translations: #{missing_translations.inspect}"
    end
  end

  config.include FactoryGirl::Syntax::Methods

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::TestingSupport::UrlHelpers

  config.include ActionDispatch::TestProcess
  config.include Devise::TestHelpers, :type => :controller
  config.include Capybara::DSL
  config.include CapybaraExt

  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::ControllerRequests
  config.include Spree::TestingSupport::Flash

  config.include Paperclip::Shoulda::Matchers

  config.extend Spree::TestingSupport::AuthorizationHelpers::Request, :type => :feature
end
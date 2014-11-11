Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_address_book'
  s.version     = '1.4.0'
  s.summary     = 'Adds address book for users to Spree'
  #s.description = 'Add (optional) gem description here'

  s.homepage          = 'http://github.com/romul/spree_address_book'
  s.authors               = ['Roman Smirnov', 'Nima Shariatian']
  s.email                 = ['roman@railsdog.com', 'nima.s@coryvines.com']
  s.required_ruby_version = '>= 2.1.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'rails', '~> 4.1.4'
  s.add_dependency 'spree_core', '~> 2.4.0.beta'

  s.add_development_dependency 'rspec-rails', '~> 3.0.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails', '~> 4.4.1'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'capybara', '~>2.4.1'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'launchy', '~> 2.4.2'
end

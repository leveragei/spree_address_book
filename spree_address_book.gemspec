Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_address_book'
  s.version     = '1.3.1'
  s.summary     = 'Adds address book for users to Spree'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 2.1.1'

  s.author            = 'Roman Smirnov'
  s.email             = 'roman@railsdog.com'
  s.homepage          = 'http://github.com/romul/spree_address_book'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'


  s.add_dependency 'rails', '~> 4.1.4'

  if s.respond_to? :specification_version
    s.specification_version = 4
     if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      s.add_runtime_dependency(%q<spree_core>, ["~> 2.3.1"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.0.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 2.4.1"])
      s.add_development_dependency(%q<factory_girl_rails>, ["~> 4.4.1"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<ffaker>, [">= 0"])
    else
      s.add_dependency(%q<spree_core>, ["~> 2.3.1"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.0.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 2.4.1"])
      s.add_dependency(%q<factory_girl_rails>, ["~> 4.4.1"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<ffaker>, [">= 0"])
    end
  else
    s.add_dependency(%q<spree_core>, ["~> 2.3.1"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.0.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 2.4.1"])
    s.add_dependency(%q<factory_girl_rails>, ["~> 4.4.1"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<ffaker>, [">= 0"])
  end

end

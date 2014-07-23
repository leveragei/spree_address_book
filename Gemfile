source "http://rubygems.org"
gemspec

group :test do
  gem 'sass-rails',   '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.1'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'rb-fsevent'
    gem 'growl'
    gem 'guard-rspec'
  end
end

gem 'devise'
gem 'devise-encryptable'
gem 'spree', github: 'spree/spree', branch: '2-3-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-3-stable'

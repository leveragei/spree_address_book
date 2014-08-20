SpreeAddressBook
================

This extension allows users select `bill_address` and `ship_address` from addresses, which was already entered by current user.


Installation
============

      Add `gem "spree_address_book", :git => "git://github.com/romul/spree_address_book.git"
      Run `bundle install`
      Run `rails g spree_address_book:install`


Tests
============

      Run `bundle exec rake test_app`
      Run `cd spec/dummy` to go to the dummy folder
      Run `bundle exec rails g spree:install`
      Run `bundle exec rails g spree_address_book:install`
      Run `cd ..` to go back to the main app
      Run `bundle exec rspec`
      
Copyright (c) 2011-2014 Roman Smirnov, released under the New BSD License

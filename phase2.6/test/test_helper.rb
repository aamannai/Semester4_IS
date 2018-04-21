require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'contexts'

class ActiveSupport::TestCase
  include Contexts
  
  def deny(condition, msg="")
    assert !condition, msg
  end  
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all


  # Add more helper methods to be used by all tests here...
end

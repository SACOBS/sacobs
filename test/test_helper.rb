ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'support/test_password_helper'
require 'minitest/rails/capybara'
require 'minitest/reporters'

Minitest::Reporters.use!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest # Rails default test framework
    with.library :rails
  end
end

class ActiveSupport::TestCase
  include TestPasswordHelper
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

ActiveRecord::FixtureSet.context_class.send :include, TestPasswordHelper

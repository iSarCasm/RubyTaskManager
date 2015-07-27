ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def valid_task_hash
    {name: "Valid task here!", done: 0, deadline: nil}
  end

  def valid_project_hash
    {name: "Valid project here!"}
  end

  def sign_in
    sign_in_and_redirect User.first
  end
  # Add more helper methods to be used by all tests here...
end

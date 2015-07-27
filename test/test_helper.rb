ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def valid_task_hash
    {name: "Valid task here!", done: 0, deadline: nil}
  end

  def valid_project_hash(options={})
    unless options[:full]
      {name: "Valid project here!"}
    else
      {name: "Valid project here!", user_id: 0}
    end
  end

  def sign_in_valid
    if integration_test?

    end
  end
  # Add more helper methods to be used by all tests here...
end

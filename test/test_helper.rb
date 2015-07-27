ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def valid_task_hash(options={})
    unless options[:full]
      {name: "Valid task here!", done: 0, deadline: nil}
    else
      {name: "Valid task here!", done: 0, deadline: nil, project_id: 0}      
    end
  end

  def valid_project_hash(options={})
    unless options[:full]
      {name: "Valid project here!"}
    else
      {name: "Valid project here!", user_id: 0}
    end
  end

  def sign_in_as (user)
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vkontakte]
    sign_in user
  end
  # Add more helper methods to be used by all tests here...
end

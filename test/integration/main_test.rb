require 'test_helper'

class MainTest < ActionDispatch::IntegrationTest
  include Devise::TestHelpers

  def setup
    @user = users(:valid_user)
  end



end

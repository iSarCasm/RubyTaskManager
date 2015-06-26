require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get sql page" do
    get :sql
    assert_response :success
  end
end

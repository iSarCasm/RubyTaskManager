require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "shouldn't show projects when not signed in" do
    #Act
    get :show
    #Assert
    assert_response :success
    assert_select ".project", 0, "Shouldnt render any projects"
  end

  test "sign out when not signed it should be success" do
    #Act
    delete :destroy
    #Assert
    assert_redirected_to root_url
  end

  test "should get sql page" do
    get :sql
    assert_response :success
  end

end

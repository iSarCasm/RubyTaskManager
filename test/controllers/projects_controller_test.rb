require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "create should require sing-in" do
    assert_no_difference 'Project.count' do
      post :create, project: valid_project_hash(full: true)
    end
    assert_redirected_to root_url
  end

  test "edit should require sign-in" do
    patch :update, id: 0, project: valid_project_hash
    assert_redirected_to root_url
  end

  test "destroy require sign-in" do
    assert_no_difference 'Project.count' do
        delete :destroy, id: 0
    end
    assert_redirected_to root_url
  end
end

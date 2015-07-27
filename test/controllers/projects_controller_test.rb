require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:valid_user)
  end

  test "create should require sing-in" do
    #NOT SIGNED
    assert_no_difference 'Project.count', "shouldn't be able to
                                          create projects when not
                                          signed it" do
      post :create, project: valid_project_hash(full: true)
    end
    assert_redirected_to root_url

    #SIGNED
    sign_in_as @user
    assert_difference 'Project.count',1,"should be able to
                                          create projects when
                                          signed it" do
      post :create, project: valid_project_hash(full: true)
    end
  end

  test "edit should require sign-in" do
    #NOT SIGNED
    patch :update, id: 0, project: valid_project_hash
    assert_redirected_to root_url, "Should redirect not signed users"

    #SIGNED
      #Arrange
    sign_in_as @user
    project =  @user.projects.first
    new_name = "New name"
    assert_not_equal project.name, new_name, "Test done wrong"
      #Act
    patch :update, id: project.id, project: {name: new_name}
      #Assert
    assert_equal new_name, project.reload.name, "Should edit title for signed users"
  end

  test "destroy require sign-in" do
    assert_no_difference 'Project.count' do
        delete :destroy, id: 0
    end
    assert_redirected_to root_url

    #SIGNED
    sign_in_as @user
    assert_difference 'Project.count',-1,"Should be able to destroy projects when signed in" do
        delete :destroy, id: @user.projects.first.id
    end
  end


end

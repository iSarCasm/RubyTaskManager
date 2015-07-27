require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  test "valid user should be valid" do
    #Arrange
    user = users(:valid_user)
    #Assert
    assert user.valid?
  end

  test "user has many projects" do
    #Arrange
    user = users(:valid_user)
    #Assert
    assert_respond_to user, :projects, "User should respong to :projects"
  end
end

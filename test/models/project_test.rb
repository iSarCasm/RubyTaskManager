require 'test_helper'

class ProjectsTest < ActiveSupport::TestCase

  def setup
    @project = projects(:valid_project)
  end


  test "projects should belong to user" do
    #Assert
    assert_respond_to @project, :user, "Project should respond to :user"
  end

  test "projects should have many tasks" do
    #Assert
    assert_respond_to @project, :tasks, "Project should respond to :tasks"
  end

  test "destroying project should destroy it's tasks" do
    #Arrange
    @project.tasks.create(valid_task_hash)
    #Assert
    assert_difference 'Task.count', -@project.tasks.count do
      @project.destroy
    end
  end

  test "name should be present" do
    #Arrange
    @project.name ="     "
    #Assert
    assert_not @project.valid?
  end

  test "name shouldnt be too long" do
    #Arrange
    @project.name = 'a'*420
    #Assert
    assert_not @project.valid?
  end
end

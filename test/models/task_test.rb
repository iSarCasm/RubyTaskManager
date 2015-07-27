require 'test_helper'

class TasksTest < ActiveSupport::TestCase

  def setup
    @task = tasks(:valid_task)
  end

  test "task should belong to project" do
    #Assert
    assert_respond_to @task, :project
  end

  test "name should be present" do
    #Arrange
    @task.name = "   "
    #Assert
    assert_not @task.valid?
  end

  test "name shouldn't be too long" do
    #Arrange
    @task.name = 'a'*420
    #Assert
    assert_not @task.valid?
  end

  test "unique priority sets by default" do
    #Arrange
    user = users(:valid_user)
    project = user.projects.create(valid_project_hash)
    #Act
    3.times { project.tasks.create(valid_task_hash)}
    #Assert
    project.tasks.each do |t1|
      project.tasks.each do |t2|
        unless t1 == t2
          assert_not_equal t1.priority, t2.priority
        end
      end
    end
  end

    test "prioritize up test" do
    #Arrange
    task = tasks(:valid_task2) #One in the middle
    top_task = tasks(:valid_task3) #One on the top
    #Assert
    assert_difference 'task.reload.priority', 1, "selected task's priority should increase" do
      assert_difference 'top_task.reload.priority',-1, "top task's priority should decrease" do
        task.prioritizeUp
      end
    end
  end

    test "prioritize down test" do
    #Arrange
    task = tasks(:valid_task2) #One in the middle
    bottom_task = tasks(:valid_task) #One on the top
    #Assert
    assert_difference 'task.reload.priority', -1, "selected task's priority should decrease" do
      assert_difference 'bottom_task.reload.priority',1, "bottom task's priority should increase" do
        task.prioritizeDown
      end
    end
  end
end

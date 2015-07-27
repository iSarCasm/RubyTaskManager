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
    project = tasks(:valid_task).project
    task_id = tasks(:valid_task2).id #One in the middle
    top_task_id = tasks(:valid_task3).id #One on the bottom
    #Assert
    assert_difference 'project.tasks.find(task_id).priority', 1, "selected task's priority should increase" do
      assert_difference 'project.tasks.find(top_task_id).priority',-1, "top task's priority should decrease" do
        project.tasks.find(task_id).prioritizeUp
      end
    end
  end

  test "prioritize down test" do
    #Arrange
    project = tasks(:valid_task).project
    task_id = tasks(:valid_task2).id #One in the middle
    bottom_task_id = tasks(:valid_task).id #One on the bottom
    #Assert
    assert_difference 'project.tasks.find(task_id).priority', -1, "selected task's priority should increase" do
      assert_difference 'project.tasks.find(bottom_task_id).priority',1, "top task's priority should decrease" do
        project.tasks.find(task_id).prioritizeDown
      end
    end
  end
end

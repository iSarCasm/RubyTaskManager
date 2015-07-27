require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:valid_user)
  end

  test "create should require sign-in" do
    assert_no_difference 'Task.count' do
      post :create, task: valid_task_hash
    end
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = valid_task_hash
    task[:project_id] = @user.projects.first.id
      #Assert
    assert_difference 'Task.count',1,"should create when signed in" do
      post :create, task: task
    end
  end

  test "destroying should require sign-in" do
    assert_no_difference 'Task.count' do
      delete :destroy, id: 0
    end
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = @user.projects.first.tasks.first
      #Assert
    assert_difference 'Task.count',-1,"should destroy when signed in" do
      delete :destroy, id: task.id
    end
  end

  test "editing title should require sign-in" do
    patch :update_title, id: 0, name: "new"
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = @user.projects.first.tasks.first
    new_name = "new name"
    assert_not_equal new_name, task.name, "Test done wrong"
      #Act
    patch :update_title, id: task.id, task: {name: new_name}
      #Assert
    assert_equal new_name, task.reload.name
  end

  test "editing deadline should require sign-in" do
    patch :update_deadline, id: 0, deadline: Time.zone.now
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = @user.projects.first.tasks.first
    task[:project_id] = @user.projects.first.id
    new_deadline = Time.zone.now.beginning_of_day
    assert_not_equal new_deadline, task.deadline, "Test done wrong"
      #Act
    patch :update_deadline, id: task.id,
          task: { "deadline(1i)" => new_deadline.year,
                  "deadline(2i)" => new_deadline.month,
                  "deadline(3i)" => new_deadline.day }
      #Assert
    assert_equal new_deadline, task.reload.deadline
  end

  test "finishing should require sign-in" do
    patch :done, id: 0, done: true
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = @user.projects.first.tasks.first
    task[:project_id] = @user.projects.first.id
    done = !task.done
      #Act
    patch :done, id: task.id, task: {done: done}
      #Assert
    assert_equal done, task.reload.done
  end

  test "prioritizing should require sign-in" do
    patch :prioritizeUp, id: 0
    assert_redirected_to root_url

    #SIGNED
      #Arrange
    sign_in_as @user
    task = @user.projects.first.tasks.first
    task[:project_id] = @user.projects.first.id
    assert_not_equal 1, @user.projects.first.tasks, "Test done worng. Should be at least 2 tasks"
      #Act
    #can up move?
    priority = task.priority
    task.prioritizeUp
    upChange = (task.reload.priority-priority)>0
    #can down move?
    priority = task.priority
    task.prioritizeDown
    downChange = (task.reload.priority-priority)<0
      #Assert
    to_assert = upChange || downChange
    assert to_assert
  end
end

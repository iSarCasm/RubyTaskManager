require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "create should require sign-in" do
    assert_no_difference 'Task.count' do
      post :create, task: valid_task_hash
    end
    assert_redirected_to root_url
  end

  test "destroying should require sign-in" do
    assert_no_difference 'Task.count' do
      delete :destroy, id: 0
    end
    assert_redirected_to root_url
  end

  test "editing title should require sign-in" do
    patch :update_title, id: 0, name: "new"
    assert_redirected_to root_url
  end

  test "editing deadline should require sign-in" do
    patch :update_deadline, id: 0, deadline: Time.zone.now
    assert_redirected_to root_url
  end

  test "finishing should require sign-in" do
    patch :done, id: 0, done: true
    assert_redirected_to root_url
  end

  test "prioritizing should require sign-in" do
    patch :prioritizeUp, id: 0
    assert_redirected_to root_url
  end
end

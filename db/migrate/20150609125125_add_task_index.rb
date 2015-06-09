class AddTaskIndex < ActiveRecord::Migration
  def change
  	add_index :tasks, [:priority, :project_id]
  end
end

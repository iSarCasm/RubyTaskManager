class TasksIndex < ActiveRecord::Migration
  def change
  	add_index :tasks, [:created_at]
  end
end

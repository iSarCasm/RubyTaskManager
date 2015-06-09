class TaskDeletePriorUnique < ActiveRecord::Migration
  def change
  	remove_index :tasks, :priority
  end
end

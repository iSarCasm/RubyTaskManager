class AddUniqueIndex < ActiveRecord::Migration
  def change
		add_index :tasks, :priority, unique: true
  end
end

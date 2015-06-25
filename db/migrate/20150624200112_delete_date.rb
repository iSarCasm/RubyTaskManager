class DeleteDate < ActiveRecord::Migration
  def change
  	remove_column :projects, :date
  end
end

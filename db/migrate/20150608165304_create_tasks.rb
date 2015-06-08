class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :priority
      t.boolean :done
      t.datetime :deadline
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

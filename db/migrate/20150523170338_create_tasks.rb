class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :progress, default: 0
      t.integer :status_id
      t.integer :priority_id
      t.integer :author_id

      t.timestamps
    end
  end
end

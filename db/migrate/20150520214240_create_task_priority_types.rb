class CreateTaskPriorityTypes < ActiveRecord::Migration
  def change
    create_table :task_priority_types do |t|
      t.string :name

      t.timestamps
    end
  end
end

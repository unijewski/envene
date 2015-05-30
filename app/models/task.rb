class Task < ActiveRecord::Base
  belongs_to :status, class_name: 'TaskStatus'
  belongs_to :priority, class_name: 'TaskPriorityType'
  belongs_to :author, class_name: 'User'

  validates :name, :description, presence: true
  validates :progress, numericality:
                       {
                         greater_than_or_equal_to: 0,
                         less_than_or_equal_to: 100
                       }
end

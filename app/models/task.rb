class Task < ActiveRecord::Base
  belongs_to :status, class_name: 'TaskStatus'
  belongs_to :priority, class_name: 'TaskPriorityType'
  belongs_to :author, class_name: 'User'
end

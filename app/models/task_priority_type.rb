class TaskPriorityType < ActiveRecord::Base
  has_many :tasks, foreign_key: 'priority_id', dependent: :destroy

  NAME_REGEX = /\A[A-Z][\w]+(\s[\w]+)*\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

class TaskStatus < ActiveRecord::Base
  NAME_REGEX = /\A[A-Z]\w+\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

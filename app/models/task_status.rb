class TaskStatus < ActiveRecord::Base
  has_many :tasks, foreign_key: 'status_id', dependent: :destroy

  NAME_REGEX = /\A[\w]+([\s]?[\w]+)*\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

class UserGroup < ActiveRecord::Base
  has_many :users, foreign_key: 'group_id'

  NAME_REGEX = /\A[A-Z]\w+\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

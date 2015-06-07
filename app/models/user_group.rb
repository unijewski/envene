class UserGroup < ActiveRecord::Base
  has_many :users, foreign_key: 'group_id', dependent: :destroy

  NAME_REGEX = /\A[\w]+([\s]?[\w]+)*\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

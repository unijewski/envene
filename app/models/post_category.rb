class PostCategory < ActiveRecord::Base
  has_many :posts, foreign_key: 'category_id', dependent: :destroy

  NAME_REGEX = /\A[\w]+([\s]?[\w]+)*\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

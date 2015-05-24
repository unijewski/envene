class PostCategory < ActiveRecord::Base
  NAME_REGEX = /\A[\w]+([\s]?[\w]+)*\z/

  validates :name, presence: true,
                   format: { with: NAME_REGEX }
end

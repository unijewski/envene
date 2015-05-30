class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :category, class_name: 'PostCategory'

  validates :title, :body, presence: true
end

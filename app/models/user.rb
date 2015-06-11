class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group, class_name: 'UserGroup'
  has_many :tasks, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  USERNAME_REGEX = /\A[A-Za-z0-9][[_|\.|-]?[A-Za-z0-9]+]{2,19}\z/

  validates :username, presence: true,
                       format: { with: USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }

  def self.search(keyword)
    where('email ILIKE ? OR username ILIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group, class_name: 'UserGroup'

  USERNAME_REGEX = /\A[A-Za-z0-9][[_|\.]?[A-Za-z0-9]+]{2,19}\z/

  validates :username, presence: true,
                       format: { with: USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :group, presence: true
end

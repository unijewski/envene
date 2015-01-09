class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  USERNAME_REGEX = /\A\w{3,}\z/

  validates :username, presence: true,
                    format: { with: USERNAME_REGEX },
                    uniqueness: { case_sensitive: false }
end

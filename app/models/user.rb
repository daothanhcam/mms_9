class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true,
    length: {maximum: Settings.user.username.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum}

  def is_admin?
    role == Settings.user.role.admin
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users

  accepts_nested_attributes_for :skill_users, allow_destroy: true

  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum}
  validates :username, presence: true, uniqueness: true,
    length: {maximum: Settings.user.username.maximum}

  def is_admin?
    role == Settings.user.role.admin
  end
end

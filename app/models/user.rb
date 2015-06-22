class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :positions, through: :position_users
  has_many :position_users, dependent: :destroy

  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum}
  validates :username, presence: true, uniqueness: true,
    length: {maximum: Settings.user.username.maximum}

  accepts_nested_attributes_for :skill_users, allow_destroy: true
  accepts_nested_attributes_for :position_users, allow_destroy: true

  def is_admin?
    role == Settings.user.role.admin
  end

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

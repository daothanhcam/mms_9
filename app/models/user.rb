class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Logs

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :positions, through: :position_users
  has_many :position_users, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :team, through: :team_users
  has_many :projects, through: :project_users
  has_many :project_users, dependent: :destroy

  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum}
  validates :username, presence: true, uniqueness: true,
    length: {maximum: Settings.user.username.maximum}


  accepts_nested_attributes_for :skill_users, allow_destroy: true
  accepts_nested_attributes_for :position_users, allow_destroy: true

  member = "id not in (select leader_id from teams union
    (select user_id from team_users))"
  member_not_in_project = "id not in (select user_id from project_users)"
  scope :user_not_team, ->{where member}
  scope :no_project, ->{where member_not_in_project}

  def is_admin?
    role == Settings.user.role.admin
  end

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  def to_csv
    CSV.generate do |csv|
      data = [self.id] + [self.username] + [self.email]
                       +[self.encrypted_password] + [self.birthday]
      skills = self.skills.map(&:name)
      csv << ["id", "name", "email", "encrypted_password", "birthday"]
      csv << data
      csv << ["skills"]
      csv << skills
    end
  end
end

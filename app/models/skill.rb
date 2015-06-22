class Skill < ActiveRecord::Base
  include Logs
  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true, uniqueness: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

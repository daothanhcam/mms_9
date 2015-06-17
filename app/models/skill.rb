class Skill < ActiveRecord::Base
  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true, uniqueness: true
end

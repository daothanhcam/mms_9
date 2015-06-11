class SkillUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :skill, presence: true
end

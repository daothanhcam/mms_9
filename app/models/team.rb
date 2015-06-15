class Team < ActiveRecord::Base
  include Logs

  has_many :team_users
  has_many :users, through: :team_users

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :leader_id, presence: true

  accepts_nested_attributes_for :users, allow_destroy: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

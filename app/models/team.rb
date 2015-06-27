class Team < ActiveRecord::Base
  include Logs
  extend CsvExport

  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :projects, dependent: :destroy
  belongs_to :leader, class_name: "User", dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  accepts_nested_attributes_for :users, allow_destroy: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

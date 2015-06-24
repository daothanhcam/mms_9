class Project < ActiveRecord::Base
  include Logs

  belongs_to :team

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  accepts_nested_attributes_for :project_users, allow_destroy: true

  delegate :name, to: :team, prefix: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

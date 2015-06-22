class Team < ActiveRecord::Base
  include Logs

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

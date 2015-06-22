class Position < ActiveRecord::Base
  has_many :users, through: :position_users
  has_many :position_users, dependent: :destroy

  validates :name, presence: true
  validates :abbreviation, presence: true,
    length: {maximum: Settings.position.abbreviation.maximum}

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy
end

class Position < ActiveRecord::Base
  has_many :users, through: :position_users
  has_many :position_users, dependent: :destroy

  validates :name, presence: true
  validates :abbreviation, presence: true,
    length: {maximum: Settings.position.abbreviation.maximum}
end

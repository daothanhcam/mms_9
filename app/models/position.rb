class Position < ActiveRecord::Base
  validates :name, presence: true
  validates :abbreviation, presence: true,
    length: {maximum: Settings.position.abbreviation.maximum}
end

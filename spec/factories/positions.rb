require "faker"

FactoryGirl.define do
  factory :position do
    name {Faker::Name.name}
    abbreviation {Faker::Lorem.characters(255)}
  end
end

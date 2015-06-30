require "rails_helper"

RSpec.describe Position, type: :model do
  let(:position) {FactoryGirl.create :position}

  subject {position}

  describe "Test associations" do
    context "Test has_many" do
      it {is_expected.to have_many(:users).through(:position_users)}
      it {is_expected.to have_many(:users)}
    end
  end

  describe "Test validates" do
    context "Create positionis valid" do
      it {is_expected.to be_valid}
    end

    context "Test empty name" do
      before {subject.name = ""}
      it {is_expected.to hava(1).error.on(:name)}
    end

    context "Test abbreviation too long" do
      before {subject.abbreviation = Faker::Lorem.characters(256)}
      it {is_expected.to hava(1).error.on(:abbreviation)}
    end
  end
end

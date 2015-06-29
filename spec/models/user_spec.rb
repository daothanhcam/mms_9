require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.build :user
  end

  describe "test validate" do
    context "test email" do
      it "should invalid when empty" do
        @user.email = nil
        expect(@user).not_to be_valid
      end

      it "should be uniqueness" do
        @user.email = "haink@gmail.com"
        @user.save
        other_user = FactoryGirl.build :user
        other_user.email = "haink@gmail.com"
        expect(other_user).not_to be_valid
      end
    end

    context "test username" do
      it "should invalid when empty" do
        @user.username = nil
        expect(@user).not_to be_valid
      end

      it "should be uniqueness" do
        @user.username = "nguyenhai"
        @user.save
        other_user = FactoryGirl.build :user
        other_user.username = "nguyenhai"
        expect(other_user).not_to be_valid
      end

      it "should invalid when length bigger 20" do
        @user.username = "123456789012345678901"
        @user.save
        expect(@user).not_to be_valid
      end
    end

    context "test password" do
      it "should be invalid when password length smaller than 8" do
        @user.password = "1234567"
        @user.password_confirmation = "1234567"
        @user.save
        expect(@user).not_to be_valid
      end

      it "shoud be invalid when password different with password_confirmation" do
        @user.password = "123456789"
        @user.password_confirmation = "1234567890"
        @user.save
        expect(@user).not_to be_valid
      end
    end
  end

  describe "Test associations" do
    context "test has_many" do
      @user = FactoryGirl.build :user
      it {expect(@user).to have_many(:skills).through(:skill_users)}
      it {expect(@user).to have_many(:teams).through(:team_users)}
      it {expect(@user).to have_many(:positions).through(:position_users)}
      it {expect(@user).to have_many(:projects).through(:project_users)}
    end
  end
end


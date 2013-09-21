require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:regular_user).should be_valid
  end

  it "is invalid with wrong email" do
    FactoryGirl.build(:regular_user, email: 'regular').should_not be_valid
    FactoryGirl.build(:regular_user, email: 'regular@vegspot').should_not be_valid
  end

  describe "#is_admin?" do
    it "returns true if user is admin" do
      FactoryGirl.build(:admin_user).is_admin?.should eq(true)
    end

    it "returns false if user is not an admin" do
      FactoryGirl.build(:regular_user).is_admin?.should eq(false)
    end
  end
end
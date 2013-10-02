require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "is invalid with wrong email" do
    FactoryGirl.build(:user, email: 'regular').should_not be_valid
    FactoryGirl.build(:user, email: 'regular@vegspot').should_not be_valid
  end

  describe "#is_admin?" do
    it "returns true if user is admin" do
      FactoryGirl.build(:user, :admin).is_admin?.should eq(true)
    end

    it "returns false if user is not an admin" do
      FactoryGirl.build(:user).is_admin?.should eq(false)
    end
  end
end
require 'spec_helper'

describe Flag do
  it "has a valid factory" do
    FactoryGirl.build(:flag, :needs_thumb).should be_valid
  end

  it "is invalid without key" do
    FactoryGirl.build(:flag, key: nil).should_not be_valid
  end

  it "is invalid when key is unknown type" do
    FactoryGirl.build(:flag, :needs_thumb, key: 'unknown_key').should_not be_valid
  end

  it "is invalid without flagged_type" do
    FactoryGirl.build(:flag, :needs_thumb, flagged_type: nil).should_not be_valid
  end

  it "is invalid without flagged_id" do
    FactoryGirl.build(:flag, :needs_thumb, flagged_id: nil).should_not be_valid
  end

  it "is invalid without owner" do
    FactoryGirl.build(:flag, :needs_thumb, user: nil).should_not be_valid
  end

  it "is valid without description" do
    FactoryGirl.build(:flag, :needs_thumb, description: nil).should be_valid
  end

  it "is invalid with too short description" do
    FactoryGirl.build(:flag, :needs_thumb, description: Faker::Lorem.characters(9)).should_not be_valid
  end

  it "is invalid with too long description" do
    FactoryGirl.build(:flag, :needs_thumb, description: Faker::Lorem.characters(501)).should_not be_valid
  end

  describe "#resolve" do
    it "is setting flag as resolved" do
      flag = FactoryGirl.create(:flag, :needs_thumb)
      flag.resolve
      flag.is_resolved?.should eq(true)
    end

    pending "is setting all related flags for given object as resolved" do
      flag1 = FactoryGirl.create(:flag, :needs_thumb)
      flag2 = FactoryGirl.create(:flag, :needs_thumb)
      flag1.resolve

      flag2.is_resolved?.should eq(true)
    end

    pending "is not setting all related flags for other objects as resolved" do
      flag1 = FactoryGirl.create(:flag, :needs_thumb)
      flag2 = FactoryGirl.create(:flag, :spam)
      flag1.resolve

      flag2.is_resolved?.should eq(false)
    end
  end
end

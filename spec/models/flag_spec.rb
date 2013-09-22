require 'spec_helper'

describe Flag do
  it "has a valid factory" do
    FactoryGirl.build(:needs_thumb_flag).should be_valid
  end

  it "is invalid without key" do
    FactoryGirl.build(:needs_thumb_flag, key: nil).should_not be_valid
  end

  it "is invalid when key is unknown type" do
    FactoryGirl.build(:needs_thumb_flag, key: 'test').should_not be_valid
  end

  it "is invalid without flagged_type" do
    FactoryGirl.build(:needs_thumb_flag, flagged_type: nil).should_not be_valid
  end

  it "is invalid without flagged_id" do
    FactoryGirl.build(:needs_thumb_flag, flagged_id: nil).should_not be_valid
  end

  it "is invalid without owner" do
    FactoryGirl.build(:needs_thumb_flag, user: nil).should_not be_valid
  end

  it "is valid without description" do
    FactoryGirl.build(:needs_thumb_flag, description: nil).should be_valid
  end

  it "is invalid with too short description" do
    FactoryGirl.build(:needs_thumb_flag, description: Faker::Lorem.characters(9)).should_not be_valid
  end

  it "is invalid with too long description" do
    FactoryGirl.build(:needs_thumb_flag, description: Faker::Lorem.characters(501)).should_not be_valid
  end

  describe "#resolve" do
    it "is setting flag as resolved" do
      flag = FactoryGirl.create(:needs_thumb_flag)
      flag.resolve
      flag.is_resolved?.should eq(true)
    end

    it "is setting all related flags for given object as resolved" do
      flag1 = FactoryGirl.create(:needs_thumb_flag)
      flag2 = FactoryGirl.create(:needs_thumb_flag)
      flag1.resolve

      flag2.is_resolved?.should eq(true)
    end

    it "is not setting all related flags for other objects as resolved" do
      flag1 = FactoryGirl.create(:needs_thumb_flag)
      flag2 = FactoryGirl.create(:spam_flag)
      flag1.resolve

      flag2.is_resolved?.should eq(false)
    end
  end
end

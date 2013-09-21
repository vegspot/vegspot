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
end

require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    FactoryGirl.build(:comment).should be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:comment, body: nil).should_not be_valid
  end

  it "is invalid with too short body" do
    FactoryGirl.build(:comment, body: "xxx").should_not be_valid
  end

  it "is invalid without an author" do
    FactoryGirl.build(:comment, user: nil).should_not be_valid
  end
end
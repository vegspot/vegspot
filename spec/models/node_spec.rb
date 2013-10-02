require 'spec_helper'

describe Node do
  it "has a valid factory" do
    FactoryGirl.build(:node).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:node, title: nil).should_not be_valid
  end

  it "is invalid without a node owner" do
    FactoryGirl.build(:node, user: nil).should_not be_valid
  end

  it "is invalid without any tags" do
    FactoryGirl.build(:node, tag_list: nil).should_not be_valid
  end

  it "is invalid with more than 5 tags" do
    FactoryGirl.build(:node, tag_list: 'One, two, three, four, five, six').should_not be_valid
  end

  it "is invalid without a node url" do
    FactoryGirl.build(:node, url: nil).should_not be_valid
  end

  it "is invalid with wrong formatted url" do
    FactoryGirl.build(:node, url: "domain.com").should_not be_valid
    FactoryGirl.build(:node, url: "domain.").should_not be_valid
    FactoryGirl.build(:node, url: "domain").should_not be_valid
  end

  it "is valid without a node body" do
    FactoryGirl.build(:node, body: nil).should be_valid
  end

  # Methods

  describe "#is_flagged?" do
    it "returns false if there are no flags" do
      FactoryGirl.build(:node).is_flagged?.should eq(false)
    end

    context "with a key parameter" do
      it "returns true if there are any flags of given type for node" do
        node = FactoryGirl.create(:node)
        user = FactoryGirl.create(:user)
        flag = Flag.build_for(node, 'needs_thumb', user).save!
        node.is_flagged?('needs_thumb').should eq(true)
      end
    end

    context "without a key parameter" do
      it "returns true if there are any flags for current node" do
        node = FactoryGirl.create(:node)
        user = FactoryGirl.create(:user)
        flag = Flag.build_for(node, 'needs_thumb', user).save!
        node.is_flagged?.should eq(true)
      end
    end
  end
end
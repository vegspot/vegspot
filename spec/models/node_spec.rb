require 'spec_helper'

describe Node do
  before(:each) do
    @node = FactoryGirl.build(:node)
  end

  it "has a valid factory" do
    @node.should be_valid
  end

  it "is invalid without a title" do
    @node.title = nil
    @node.should_not be_valid
  end

  it "is invalid without an owner" do
    @node.user = nil
    @node.should_not be_valid
  end

  it "is invalid without any tags" do
    @node.tag_list = nil
    @node.should_not be_valid
  end

  it "is invalid with more than 5 tags" do
    @node.tag_list = 'One, two, three, four, five, six'
    @node.should_not be_valid
  end

  it "is invalid without an url" do
    @node.url = nil
    @node.should_not be_valid
  end

  it "is invalid with wrong formatted url" do
    @node.url = 'domain.com'
    @node.should_not be_valid

    @node.url = 'domain.'
    @node.should_not be_valid

    @node.url = 'domain'
    @node.should_not be_valid
  end

  it "is setting a status to 'pending' by default" do
    @node.status = nil
    @node.should be_valid
    @node.status.should eq 'pending'
  end

  it "is invalid with wrong status" do
    @node.status = 'wrong_status'
    @node.should_not be_valid
  end

  it "is valid without a node body" do
    @node.body = nil
    @node.should be_valid
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
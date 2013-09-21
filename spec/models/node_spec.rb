require 'spec_helper'

describe Node do
  it "has a valid factory" do
    FactoryGirl.build(:link_node).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:link_node, title: nil).should_not be_valid
  end

  it "is invalid without a node type" do
    FactoryGirl.build(:link_node, node_type: nil).should_not be_valid
  end

  it "is invalid with wrong node type" do
    FactoryGirl.build(:text_node, node_type: 9999).should_not be_valid
  end

  it "is invalid without a node owner" do
    FactoryGirl.build(:link_node, user: nil).should_not be_valid
  end

  it "is invalid without any tags"
  it "is invalid with more than 5 tags"

  context "type link" do
    it "is invalid without a node url" do
      FactoryGirl.build(:link_node, url: nil).should_not be_valid
    end

    it "is valid without a node body" do
      FactoryGirl.build(:link_node, body: nil).should be_valid
    end

    it "is invalid with wrong formatted url" do
      FactoryGirl.build(:link_node, url: "domain.com").should_not be_valid
      FactoryGirl.build(:link_node, url: "domain.").should_not be_valid
      FactoryGirl.build(:link_node, url: "domain").should_not be_valid
    end
  end

  context "type text" do
    it "is invalid without a node body" do
      FactoryGirl.build(:text_node, body: nil).should_not be_valid
    end

    it "is valid without a node url" do
      FactoryGirl.build(:text_node, url: nil).should be_valid
    end
  end

  # Methods
  describe "#is_text?" do
    it "returns true for text node" do
      FactoryGirl.build(:text_node).is_text?.should eq(true)
    end

    it "returns false for link node" do
      FactoryGirl.build(:link_node).is_text?.should eq(false)
    end
  end

  describe "#is_link?" do
    it "returns true for link node" do
      FactoryGirl.build(:link_node).is_link?.should eq(true)
    end
    it "returns false for text node" do
      FactoryGirl.build(:text_node).is_link?.should eq(false)
    end
  end
end
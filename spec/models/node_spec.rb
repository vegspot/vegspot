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

  it "is invalid without any tags" do
    FactoryGirl.build(:link_node, tag_list: nil).should_not be_valid
  end

  it "is invalid with more than 5 tags" do
    FactoryGirl.build(:link_node, tag_list: "One, two, three, four, five, six").should_not be_valid
  end

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

  describe "#fetch_thumbnail" do
    # Commenting these out cause they are slow
    #
    # it "fetches thumbnail for a link node" do
    #   FactoryGirl.create(:link_node).thumbnail.should_not eq(nil)
    # end

    # it "returns true if thumbnail has been fetched" do
    #   FactoryGirl.build(:link_node).fetch_thumbnail.should eq(true)
    # end

    # it "returns false if thumbnail has not been fetched" do
    #   FactoryGirl.build(:link_node, url: 'http://google.pl').fetch_thumbnail.should eq(false)
    # end
    
    it "sets 'needs_thumb' flag if thumbnail has not been fetched"
  end
end
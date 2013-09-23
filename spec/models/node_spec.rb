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

  describe "#is_flagged?" do
    it "returns false if there are no flags" do
      FactoryGirl.build(:link_node).is_flagged?.should eq(false)
    end

    context "with a key parameter" do
      it "returns true if there are any flags of given type for node" do
        node = FactoryGirl.create(:link_node)
        user = FactoryGirl.create(:regular_user)
        flag = Flag.build_for(node, 'needs_thumb', user).save!
        node.is_flagged?('needs_thumb').should eq(true)
      end
    end

    context "without a key parameter" do
      it "returns true if there are any flags for current node" do
        node = FactoryGirl.create(:link_node)
        user = FactoryGirl.create(:regular_user)
        flag = Flag.build_for(node, 'needs_thumb', user).save!
        node.is_flagged?.should eq(true)
      end
    end
  end

  describe "#fetch_thumbnail" do
    before(:each) do
      @node = FactoryGirl.create(:link_node)
    end

    it "returns true if image has been fetched" do
      @node.fetch_thumbnail.should eq(true)
    end

    it "returns false if image has not been fetched" do
      @node.url = 'http://google.pl'
      @node.fetch_thumbnail.should eq(false)
    end

    it "not fetches gif images" do
      @node.fetch_thumbnail
      FastImage.type(@node.thumbnail.path).should_not eq(:gif)
    end

    it "fetches the biggest image from a given link" do
      @node.fetch_thumbnail
      @node.thumbnail.filename.should eq('4.jpg')
    end

    it "sets 'needs_thumb' flag if thumbnail has not been fetched" do
      @node.url = 'http://google.pl'
      @node.fetch_thumbnail
      @node.is_flagged?('needs_thumb').should eq(true)
    end
  end

  describe "#actors" do
    it "returns a list of unique actors for node"
  end
end
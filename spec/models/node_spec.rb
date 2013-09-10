require 'spec_helper'

describe Node do
  fixtures :nodes, :users

  before(:each) do
    @new_node       = Node.new
    @new_node.title = 'Test node'
    @new_node.user  = users(:regular)
    @new_node.url   = 'http://domain.com'
    @new_node.node_type = 0
  end

  it "should require a title" do
    @new_node.title = nil
    @new_node.should_not be_valid
  end

  it "should require a node type" do
    @new_node.node_type = nil
    @new_node.should_not be_valid
  end

  it "should require a node owner" do
    @new_node.user = nil
    @new_node.should_not be_valid
  end

  it "should validate title length" do
    pending
  end

  context "type is link" do
    before(:each) do
      @new_node.node_type = 0
      @new_node.url       = 'http://domain.com'
    end

    it "should require a node url" do
      @new_node.url = nil
      @new_node.should_not be_valid
    end

    it "should not require a node body" do
      @new_node.body = nil
      @new_node.should be_valid
    end

    it "should not be save with wrong formatted url" do
      @new_node.url = "domain.com"
      @new_node.should_not be_valid

      @new_node.url = "http://domain"
      @new_node.should_not be_valid

      @new_node.url = "www"
      @new_node.should_not be_valid
    end
  end

  context "type is text" do
    before(:each) do
      @new_node.node_type = 1
      @new_node.body      = 'Example body'
    end

    it "should require a node body" do
      @new_node.body = nil
      @new_node.should_not be_valid
    end

    it "should not require a node url" do
      @new_node.url = nil
      @new_node.should be_valid
    end

    it "should validate body length" do
      pending
    end

  end
end

describe Node do
  fixtures :nodes

  describe "#is_text?" do
    it "returns true for text node" do
      node = nodes(:text)
      node.is_text?.should eq(true)
    end

    it "returns false for link node" do
      node = nodes(:link)
      node.is_text?.should eq(false)
    end
  end
end
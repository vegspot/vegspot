require 'spec_helper'

describe Node do
  fixtures :nodes

  it "should not save node without a type" do
    node = Node.new
    node.title = 'Test node without a type'
    node.url   = 'http://vegspot.net'
    node.save.should eq(false)
  end
end

describe Node, '#is_text?' do
  fixtures :nodes

  it "returns true for text node" do
    node = nodes(:text)
    node.is_text?.should eq(true)
  end

  it "returns false for link node" do
    node = nodes(:link)
    node.is_text?.should eq(false)
  end
end
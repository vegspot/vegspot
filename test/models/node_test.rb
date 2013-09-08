require 'test_helper'

class NodeTest < ActiveSupport::TestCase

  test "should not save node without a type" do
    node       = Node.new
    node.title = 'Test node without a type'
    node.url   = 'http://vegspot.net'
    refute node.save, "Saved node without a type"
  end

  test "should not save node of any type without the title" do
    node           = Node.new
    node.node_type = 0
    node.user      = users(:regular)
    node.url       = 'http://vegspot.net'
    refute node.save, "Saved node without a title"
  end

  test "should not save node of link type without the URL" do
    node           = Node.new
    node.user      = users(:regular)
    node.node_type = 0
    node.title     = "Test node without a URL"
    refute node.save, "Saved link node without an URL"
  end

  test "should not save node without an author" do
    node           = Node.new
    node.node_type = 0
    node.title     = 'Test link'
    node.url       = 'http://wikipedia.org'
    refute node.save, "Saved node without an author"
  end

  test "should not save text node with wrong body" do
    node           = Node.new
    node.node_type = 1
    node.title     = "Example text node"
    node.user      = users(:regular)
    refute node.save, "Saved node without a body"

    node.body      = "Abc"
    assert !node.save, "Saved node with too short body"
  end

  test "should save a regular link node" do
    node           = Node.new
    node.title     = "Test"
    node.user      = users(:regular)
    node.url       = 'http://vegspot.net'
    node.node_type = 0
    assert node.save, "Not saved a link node"
  end

  test "should save regular text node" do
    node           = Node.new
    node.node_type = 1
    node.user      = users(:regular)
    node.title     = "Test"
    node.body      = "Example content."
    assert node.save, "Not saved a text node"
  end

end
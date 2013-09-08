require 'test_helper'

class NodeTest < ActiveSupport::TestCase

  test "week scope should contain only nodes created no more than one week ago" do
    nodes = Node.this_week
    nodes.each do |node|
      assert node.created_at >= (Date.today-1.week), "There is a node older than a week: #{node.title}"
    end
  end

  test "week scope should also include nodes added exactly 7 days ago" do
    nodes = Node.this_week
    assert nodes.include?(nodes(:week_ago)), "Node added 7 days ago is not included."
  end

  test "month scope should also include nodes added exactly 1 month ago" do
    nodes = Node.this_month
    assert nodes.include?(nodes(:month_ago)), "Node added 1 month ago is not included."
  end

  test "fetch_thumbnail() should fetch a proper thumbnail from given url" do
    node = nodes(:link)
    node.fetch_thumbnail
    desired_thumbnail_filename = 'BeFunky_VintageColors_1.jpg'

    assert node.thumbnail.filename == desired_thumbnail_filename, "Wrong thumbnail has been fetched: #{node.thumbnail.filename}"
  end

  test "set_title() should create a new Site without 'http://www.' part" do
    node = Node.new
    node.node_type = 0
    node.user = users(:regular)
    node.title = 'Test link without www'
    node.url = 'http://www.vegspot.net'
    node.save
    assert node.site.address == 'vegspot.net', "Address not saved properly: #{node.site.address}"
  end

end

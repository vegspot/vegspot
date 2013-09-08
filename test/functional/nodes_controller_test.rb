require 'test_helper'

class NodesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @node = nodes(:link)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nodes)
  end

  test "should not get new for guest" do
    assert_raises CanCan::AccessDenied do
      get :new
    end
  end

  test "should get new for signed in user" do
    sign_in users(:regular)
    get :new
    assert_response :success
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create node" do
  #   sign_in users(:admin)
  #   assert_difference('Node.count') do
  #     post :create, node: { body: @node.body, thumbnail: @node.thumbnail, title: @node.title }
  #   end

  #   assert_redirected_to node_path(assigns(:node))
  # end

  # test "should show node" do
  #   get :show, id: @node
  #   assert_response :success
  # end

  test "should not get edit for guest" do
    assert_raises CanCan::AccessDenied do
      get :edit, id: @node
    end
  end

  test "should get edit for node owner" do
    sign_in users(:regular)
    get :edit, id: nodes(:link)
    assert_response :success
  end

  test "should not get edit for not node owner" do
    sign_in users(:regular)
    assert_raises CanCan::AccessDenied do
      get :edit, id: nodes(:text)
    end
  end

  # test "should update node" do
  #   put :update, id: @node, node: { body: @node.body, thumbnail: @node.thumbnail, title: @node.title }
  #   assert_redirected_to node_path(assigns(:node))
  # end

  # test "should destroy node" do
  #   assert_difference('Node.count', -1) do
  #     delete :destroy, id: @node
  #   end

  #   assert_redirected_to nodes_path
  # end
end

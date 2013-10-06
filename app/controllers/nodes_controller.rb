class NodesController < ApplicationController
  before_action :get_recent_comments, only: [:index]
  before_action :get_related_nodes, only: [:show]

  #load_and_authorize_resource

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.live.popular

    # Determine timed scope
    case params[:for]
      when 'month'
        @nodes      = @nodes.this_month
        @for_filter = 'month'
      when 'all'
        @nodes      = @nodes
        @for_filter = 'all'
      else
        @nodes      = @nodes.this_week
        @for_filter = 'week'
    end

    # Add pagination
    @nodes = @nodes.page(params[:page]).per(36)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  def recent
    @nodes      = Node.live.recent.this_week.page(params[:page]).per(36)
    @for_filter = 'week'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/saved
  # Displays saved nodes for user
  def saved
    @nodes = current_user.saved_nodes
    respond_to do |format|
      format.js
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @node     = Node.find(params[:id])
    @comment  = Comment.new
    @comments = @node.root_comments

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(node_params)
    @node.user = current_user

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

  # POST /nodes/:id/save
  # Saves / unsave a node
  def save
    @node = Node.find(params[:id])
    current_user.save(@node)

    respond_to do |format|
      format.js
    end
  end

  def share
    @node = Node.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # Fetch page title of given url
  def fetch_title
    doc = Nokogiri::HTML(open(params[:node][:url]))
    title = doc.css('title').first.content
    render json: { title: title }
  end

  # Casts a vote on node.
  def vote
    @node = Node.find(params[:id])

    # if user has allready voted, remove his vote.
    if current_user.voted_for?(@node)
      current_user.unvote_for(@node)

    # or else, delete any existing vote by this user and cast a new FOR one.
    else
      current_user.vote_exclusively_for(@node)
    end    

    # Update karma counters
    @node.user.update_karma_counter
    @node.update_score

    respond_to do |format|
      format.js
    end
  end

  private
  def node_params
    if can? :manage, Node
      params.require(:node).permit(:url, :title, :body, :remote_thumbnail_url, :tag_list, :status, :node_type)
    else
      params.require(:node).permit(:url)
    end
  end

  # Get recent comments
  def get_recent_comments
    @recent_comments = Comment.recent.limit(5)
  end

  # Get related nodes
  def get_related_nodes
    @related_nodes = Node.popular.limit(10)
  end
end

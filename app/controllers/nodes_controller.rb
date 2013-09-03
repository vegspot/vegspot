class NodesController < ApplicationController
  # GET /nodes
  # GET /nodes.json
  def index
    case params[:mode]
    when 'recent'
      @nodes = Node.recent
    else
      @nodes = Node.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @node = Node.find(params[:id])

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

  # Fetch page title of given url
  def fetch_title
    doc = Nokogiri::HTML(open(params[:node][:url]))
    title = doc.css('title').first.content
    render json: { title: title }
  end

  # Casts a vote on node.
  def vote
    @node = Node.find(params[:id])

    # If user is voting for
    if params[:vote] == 'for'

      # if user has allready voted, remove his vote.
      if current_user.voted_for?(@node)
        current_user.unvote_for(@node)

      # or else, delete any existing vote by this user and cast a new FOR one.
      else
        current_user.vote_exclusively_for(@node)
      end

    # Everything in this elsif statement works the oposite way than in if statement. 
    elsif params[:vote] == 'against'
      if current_user.voted_against?(@node)
        current_user.unvote_for(@node)
      else
        current_user.vote_exclusively_against(@node)
      end      
    end

    # Update karma counter
    @node.user.update_karma_counter

    respond_to do |format|
      format.js
    end
  end

  private
  def node_params
    params.require(:node).permit(:url, :title, :body, :remote_thumbnail_url, :tag_list)
  end
end

class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @node    = Node.find(params[:node_id])
    @comment = Comment.build_from(@node, current_user.id, params[:comment][:body])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @node, notice: 'Comment added.' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @node, notice: 'Error.' }
        format.js
      end      
    end
  end

end

class CommentsController < ApplicationController

  def index
    @comments = Comment.all
    @mode     = 'popular'

    # Determine timed scope
    case params[:for]
      when 'month'
        @comments   = @comments.this_month
        @for_filter = 'month'
      when 'all'
        @comments   = @comments
        @for_filter = 'all'
      else
        @comments   = @comments.this_week
        @for_filter = 'week'
    end
  end

  def recent
    @comments   = Comment.recent.this_week.page(params[:page]).per(36)
    @for_filter = 'week'
    @mode       = 'recent'

    render :index
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

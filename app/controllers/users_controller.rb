class UsersController < ApplicationController

  def show
    @user  = User.find(params[:id])
    @nodes = @user.nodes

    case params[:sort]
    when 'popular'
      @nodes  = @nodes.popular
      @filter = 'popular'
    else
      @nodes  = @nodes.recent
      @filter = 'recent'
    end
  end

  def saves
    @user  = User.find(params[:user_id])
    @nodes = @user.flaggings(Node).map { |f| f.flaggable }
  end

end
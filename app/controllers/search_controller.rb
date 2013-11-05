class SearchController < ApplicationController

  def index
    @nodes = Node.search(params[:q], load: true)
  end

end
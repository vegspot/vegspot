class SearchController < ApplicationController

  def index
    @nodes = Node.search(params[:q])
  end

end
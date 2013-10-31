class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @nodes = @user.nodes
  end

end
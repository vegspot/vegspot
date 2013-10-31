class UserCommentsController < ApplicationController
  before_action :set_user

  def index
    @comments = @user.comments

    case params[:sort]
    when 'popular'
      # TODO: implement `popular` scope
      # @comments  = @comments.popular
      @filter   = 'popular'
    else
      @comments = @comments.recent
      @filter   = 'recent'
    end

    render 'users/comments/index'
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

end
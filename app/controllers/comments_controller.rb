# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i(index)

  def new
    @comment = Comment.new
  end

  def create
    Comment.create(comment_params)
    redirect_to placement_path(params[:comment][:placement_id])
  end
  
  def edit
  #  byebug
    @comment = current_user.comments.find(params[:id]) 
    @placement = Placement.find(params[:id])
    session[:return_to] ||= request.referer
  end
  
  def update
   # byebug
    @comment = Comment.find(params[:id]) 
    @comment.update!(comment_params)
    redirect_to placement_path(@comment.placement_id)
  end
  
  def index
    @comments = Comment.all.sort_by {|obj| obj.created_at }.reverse
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if current_user.admin?
      redirect_to comments_path
    elsif current_user == @comment.user
      redirect_to placement_path(@comment.placement_id)
    end
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:user_id, :placement_id, :text)
    end
end

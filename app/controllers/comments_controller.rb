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
  
  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to placement_path(@comment.placement_id)
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:user_id, :placement_id, :text)
    end
end

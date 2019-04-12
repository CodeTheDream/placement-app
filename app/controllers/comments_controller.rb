# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    Comment.create(
      user_id: params[:comment][:user_id],
      placement_id: params[:comment][:placement_id],
      text: params[:comment][:text]
    )
    redirect_to placement_path(params[:comment][:placement_id])
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to placement_path(@comment.placement_id)
  end
end

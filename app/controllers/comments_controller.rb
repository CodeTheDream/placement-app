class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @comment = Comment.new
    end

    def create
        Comment.create(
            user_id: params[:comment][:user_id],
            placement_id: params[:comment][:placement_id],
            text: params[:comment][:text],
            )
        redirect_to placement_path(params[:comment][:placement_id])
    end
    
    #def edit
        #render edit via new_comment form
    #end
        #store edit into comments table
    #def update
    
    #end
    
    def destroy
       # @placement = Placement.find(params[:comments][:placement_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to placement_path(@comment.placement_id)
    end
    
    
end

class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        if params[:query].present?
            @placements = Placement.search_for(params[:query])
        else
            @placements = Placement.all
        end
    end
 
end



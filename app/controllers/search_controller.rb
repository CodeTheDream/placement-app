class SearchController < ApplicationController
    
    def index
   if params[:query].present?
     @placements = Placement.search_for(params[:query])
   else
     @placements = Placement.all
   end
 end
 
end

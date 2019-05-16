class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        if params[:query].present?
            @placements = Placement.search_for(params[:query])
            
            @licensees = Licensee.all
          
        # Attempts at grouping placements by licensee in search results
          
        # 1
          
            #@licensees = Licensee.where(id: @placements.pluck(:licensee_id))
        
        # 2
        
            #@placements.collect do |p|
             #   @licensees << p.licensee.attributes
            #end
        
        else
            @placements = Placement.all
            @licensees = Licensee.all
        end
    end
 
end



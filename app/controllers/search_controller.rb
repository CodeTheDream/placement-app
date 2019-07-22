class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        if params[:query].present?
            @placements = Placement.search_for(params[:query], params[:service]) 
            @licensees = Licensee.all
            @services = Service.all
        else
            @placements = Placement.all
            @licensees = Licensee.all
            @services = Service.all
        end
    end
 
end



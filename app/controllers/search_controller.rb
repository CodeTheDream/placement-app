class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @licensees = Licensee.all
        @services = Service.all
        @counties = County.all
        if params[:filtercounty] || params[:filterservice] || params[:query]
            @placements = Placement.all
            @placements = @placements.filter_county(params[:filtercounty]) if params[:filtercounty].present?
            @placements = @placements.filter_service(params[:filterservice]) if params[:filterservice].present?
            @placements = @placements.search_for(params[:query]) if params[:query].present?
        end
    end
end

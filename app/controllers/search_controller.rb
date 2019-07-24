class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @licensees = Licensee.all
        @services = Service.all
        if params[:filtercounty] || params[:filterservice] || params[:query]
            #byebug
            @placements = Placement.filter_county(params[:filtercounty]) if params[:filtercounty].present?
            @placements.filter_service(params[:filterservice]) if params[:filterservice].present?
            @placements.search_for(params[:query]) if params[:query].present?
            return @placements
            if @placements == nil
                @placements = Placement.all
            end
        end
    end
end

#        if params[:filter_county].present? || params[:filter_service].present?
#            @placements = Placement.filter_county(params[:filter_county]).filter_service(params[:filter_service])
#            @licensees = Licensee.all
#            @services = Service.all
#        elsif params[:query].present? 
#            @placements = Placement.search_for(params[:query]) 
#            @licensees = Licensee.all
#            @services = Service.all
#        else
#            @placements = Placement.all
#            @licensees = Licensee.all
#            @services = Service.all
#        end

#        case params[]
#            when params[:filter_county].present? 
#                @placements = Placement.all
#                @placements.filter_county(params[:filter_county])
#                @placements
#                @licensees = Licensee.all
#                @services = Service.all 
#            when params[:filter_service].present?
#               @placements = Placement.all
#               @placements.filter_service(params[:service])
#                @placements
#                @licensees = Licensee.all
#                @services = Service.all 
#            when params[:filter_county].present? && params[:filter_service].present?
#               @placements = Placement.all
#                @placements.filter_county(params[:filter_county]).filter_service(params[:service])
#                @placements
#               @licensees = Licensee.all
#               @services = Service.all 
#            when params[:query].present? 
#                @placements = Placement.search_for(params[:query]) 
#                @licensees = Licensee.all
#                @services = Service.all
#            else
#                @placements = Placement.all
#                @licensees = Licensee.all
#                @services = Service.all 
#        end

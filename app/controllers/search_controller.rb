class SearchController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @licensees = Licensee.all
        @services = Service.all
        @counties = County.all.order(:name)
        if params[:filtercounty] || params[:filterservice] || params[:query]
            @placements = Placement.all
            @placements = @placements.filter_county(params[:filtercounty]) if params[:filtercounty].present?
            @placements = @placements.filter_service(params[:filterservice]) if params[:filterservice].present?
            @placements = @placements.filter_mco(params[:filtermco]) if params[:filtermco].present?
            @placements = @placements.filter_hospital(params[:filterhospital]) if params[:filterhospital].present?
            @placements = @placements.search_for(params[:query]) if params[:query].present?
            @locations = (@placements.map { |a| [a.latitude.to_f, a.longitude.to_f] }).to_json
        
        # Hash to build map with multiple markers on index page. 
            @hash = Gmaps4rails.build_markers(@placements) do |placement, marker|
                placement_path = view_context.link_to placement.name, placement_path(placement)  #or is it placement.id?
                marker.lat placement.latitude
                marker.lng placement.longitude  
                marker.infowindow "<b>#{placement_path}</b>"
            end
            
        end
    end
end

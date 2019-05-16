class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @announcement = Announcement.new
    @licensees = Licensee.order(:facility_name).all
    @placements = Placement.order(:name).all
  end
  
  def create
    Announcement.create(announcement_params)
    redirect_to announcements_path
  end
  
  def index
    @announcements = Announcement.all
    @announcement = Announcement.new
    @licensees = Licensee.all
    @placements = Placement.all
  end
  
  def edit
    @announcement = Announcement.find(params[:id])
    @licensees = Licensee.order(:facility_name).all
    @placements = Placement.order(:name).all
  end
  
  def update
    Announcement.update(announcement_params)
    redirect_to announcements_path
  end
  
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to announcements_path
  end
  
  private
  
    def announcement_params
      params.require(:announcement).permit(:user_id, :text, :placement_id, 
                                          :licensee_id, :bed_available)
    end
end

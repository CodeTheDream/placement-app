class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @announcement = Announcement.new
    @licensees = Licensee.all
    @placements = Placement.all
  end
  
  def create
    #byebug
    Announcement.create(
      user_id: params[:announcement][:user_id],
      placement_id: params[:announcement][:placement_id],
      licensee_id: params[:announcement][:licensee_id],
      bed_available: params[:announcement][:bed_available],
      text: params[:announcement][:text]
    )
    redirect_to announcements_path
  end
  
  def index
    @announcements = Announcement.all
    @announcement = Announcement.new
    @licensees = Licensee.all
    @placements = Placement.all
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

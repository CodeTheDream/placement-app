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
    @announcements = Announcement.all.sort_by {|obj| obj.created_at }.reverse
    @announcement = Announcement.new
    @placements = Placement.all.order(:name)
  end
  
  def edit
    @announcement = Announcement.find(params[:id])
    @licensees = Licensee.order(:facility_name).all
    @placements = Placement.order(:name).all
    session[:return_to] ||= request.referer
  end
  
  def update
    @announcement = Announcement.find(params[:id])
    @announcement.update!(announcement_params)
    @licensees = Licensee.order(:facility_name).all
    @placements = Placement.order(:name).all
    if session[:return_to] != nil
      redirect_to session.delete(:return_to)
    else
      redirect_to root_path
    end
  end
  
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to announcements_path
  end
  
  private
  
    def announcement_params
      params.require(:announcement).permit(:id, :user_id, :text, :placement_id, 
                                          :licensee_id, :bed_available)
    end
end

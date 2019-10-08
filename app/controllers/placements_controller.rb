# frozen_string_literal: true

class PlacementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i(new edit destroy)

  require 'roo'

  def new
    @placement = Placement.new
    @licensees = Licensee.all
    @services = Service.all
    @counties = County.all
  end

  def create
    p = Placement.create(placement_params)
    redirect_to admins_path
  end

  def index
    @licensees = Licensee.all
    @placements = Placement.all.order(:id)
    @services = Service.all
    @counties = County.all
    respond_to do |format|
    format.xlsx do
      response.headers[
        'Content-Disposition'
      ] = 'attachment; filename=placements.xlsx'
    end
    format.html { render :index }
    end
  end
  
  def show
    @placement = Placement.find(params[:id])
    @licensee = Licensee.find(@placement.licensee_id)
    @service = Service.find(@placement.service_id)
    @comment = Comment.new(placement_id: @placement.id)
    @comments = @placement.comments.collect.sort_by {|obj| obj.created_at }.reverse
    # Hash to build map with one marker on show page. 
    @hash = Gmaps4rails.build_markers(@placement) do |placement, marker|
      marker.lat placement.latitude
      marker.lng placement.longitude  
      marker.infowindow placement.name
    end
  end
  
  def edit
    @placement = Placement.find(params[:id])
    @licensees = Licensee.all
    session[:return_to] ||= request.referer #this and the redirect in the update
    # action redirect you back to the previous page after you update a placement
  end

  def update
    @placement = Placement.find(params[:id])

    @placement.update!(placement_params)
    if session[:return_to] != nil
      redirect_to session.delete(:return_to)
    else
      redirect_to root_path
    end
  end

  def destroy
    @placement = Placement.find(params[:id])
    @placement.destroy
    redirect_to placements_path
  end

  def comment
    @comment = Comment.new
  end

  private

    def placement_params
     params.require(:placement).permit(:name, :address, :city, :state, :zip,
                                      :county, :phone, :licensee_id, :gender,
                                      :beds, :search)
    end
end
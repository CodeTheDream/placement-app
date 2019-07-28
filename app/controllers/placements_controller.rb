# frozen_string_literal: true

class PlacementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i(new edit)

  require 'roo'

  def new
    @placement = Placement.new
    @licensees = Licensee.all
    @services = Service.all
  end

  def create

    p = Placement.create(placement_params)
    
    redirect_to admins_path
  end

  def index
    if params[:query].present?
      @licensees = Licensee.all
      @placements = Placement.search_for(params[:query])
    else
      @licensees = Licensee.all
      @placements = Placement.all
    end
    @locations = (Placement.all.map { |a| [a.latitude.to_f, a.longitude.to_f] }).to_json
  end
  
  def show
    @placement = Placement.find(params[:id])
    @licensee = Licensee.find(@placement.licensee_id)
    @comment = Comment.new(placement_id: @placement.id)
    @comments = @placement.comments.collect
        
    # This may consume too much memory if the table is big.
    # Placement.all.each do |c|
    #   @locations = [[c.latitude, c.longitude].to_json
    # end
  end
  
  def map
    @licensees = Licensee.all
    @placements = Placement.all
    @locations = (Placement.all.map { |a| [a.latitude.to_f, a.longitude.to_f] }).to_json

    # @locations = Placement.all.map { |a| [a.latitude.to_f, a.longitude.to_f] }
        # @locations =  [[35.8961813,-78.87255], [35.8966316,-78.8697565], [35.896636,-78.8675731]].to_json
    
    # works  
    # Placement.all.each do |c|
    
    #   @locations = [[c.latitude, c.longitude]].to_json
    #   puts @locations
    # end
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

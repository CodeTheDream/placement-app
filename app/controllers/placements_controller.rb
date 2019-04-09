# frozen_string_literal: true

class PlacementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[new edit]

  require 'roo'

  def new
    @placement = Placement.new
    @licensees = Licensee.all
    @services = Service.all
  end

  def create
    Placement.create(placement_params)
    redirect_to admins_path
  end

  # licensee_id: params[::placement][:licensee_id]
  # service_id: params[:placement][:service_id],

  def index
    @placements = Placement.all
    search = "%#{params[:search]}%"
    @placements_search = Placement.where('name LIKE ? OR county LIKE ?', search, search)
  end
  
  def show
    @placement = Placement.find(params[:id])
    @licensee = Licensee.find(@placement.licensee_id)
    @comment = Comment.new(placement_id: @placement.id)
    @comments = @placement.comments.collect
  end

  def edit
    @placement = Placement.find(params[:id])
    @licensees = Licensee.all
  end

  def update
    @placement = Placement.find(params[:id])
    @placement.update!(placement_params)
    redirect_to placement_path(@placement)
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
                    :county, :phone, :licensee_id, :gender, :beds, :search)
    end
end

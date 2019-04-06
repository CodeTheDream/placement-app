class PlacementsImportsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin

  def new
    @placements_import = PlacementsImport.new
  end

  def create
    @placements_import = PlacementsImport.new(params[:placements_import])
    if @placements_import.save
      redirect_to placements_path
    else
      render :new
    end
  end

end
class PlacementsImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def new
    @placements_import = PlacementsImport.new
  end

  def create
    @placements_import = PlacementsImport.new(placements_import_params)
    if @placements_import.save
      redirect_to admins_path
      flash[:notice] = "Placements successfully uploaded!"
    else
      render :new
    end
  end

  private

  def placements_import_params
    params.require(:placements_import).permit(:file)
  end
end

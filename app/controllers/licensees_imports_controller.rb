class LicenseesImportsController < ApplicationController
  
  def new
    @licensees_import = LicenseesImport.new
  end

  def create
    @licensees_import = LicenseesImport.new(params[:licensees_import])
    if @licensees_import.save
      redirect_to licensees_path
    else
      render :new
    end
  end
end

class LicenseesImportsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_admin
  
  def new
    @licensees_import = LicenseesImport.new
  end

  def create
    @licensees_import = LicenseesImport.new(licensees_import_params)
    #@licensees_import = LicenseesImport.new(params[:licensees_import])
    #byebug
    if @licensees_import.save
      redirect_to licensees_path
    else
      render :new
    end
  end
  
  private
  
    def licensees_import_params
      params.require(:licensees_import).permit(:file)
      #permit(:content_type, :headers, :original_filename, :tempfile)
    end
end

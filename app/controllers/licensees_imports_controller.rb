class LicenseesImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def new
    @licensees_import = LicenseesImport.new
  end

  def create
    @licensees_import = LicenseesImport.new(licensees_import_params)
    if @licensees_import.save
      redirect_to admins_path
      flash[:notice] = "Licensees successfully uploaded!"
    else
      render :new
    end
  end

  private

  def licensees_import_params
    params.require(:licensees_import).permit(:file)
  end
end

# frozen_string_literal: true

class LicenseesController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[new edit]
    
    def new
      @licensee = Licensee.new
    end

    def create
      Licensee.create(licensee_params)
      redirect_to licensees_path
    end

    def index
      @licensees = Licensee.all
        respond_to do |format|
          format.xlsx {
            response.headers[
              'Content-Disposition'
              ] = "attachment; filename=licensees.xlsx"
            }
            format.html { render :index }
        end
    end
    
    def show
      @licensee = Licensee.find(params[:id])
    end
    
    def edit
      @licensee = Licensee.find(params[:id]) 
    end

    def update
      @licensee = Licensee.find(params[:id])
      @licensee.update!(licensee_params)
      redirect_to licensee_path(@licensee)
    end
    
    def destroy
      @licensee = Licensee.find(params[:id])
      @licensee.destroy
      redirect_to licensees_path
    end
    
    private
      
      def licensee_params
        params.require(:licensee).permit(:facility_name, :contact_name,
                                 :address, :city, :state, :zip, :phone, :fax)
      end
    
end

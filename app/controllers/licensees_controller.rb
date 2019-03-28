class LicenseesController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @licensee = Licensee.new
    end

    def create
        Licensee.create(
            facility_name: params[:licensee][:facility_name],
            contact_name: params[:licensee][:contact_name],
            address: params[:licensee][:address],
            city: params[:licensee][:city],
            state: params[:licensee][:state],
            zip: params[:licensee][:zip],
            phone: params[:licensee][:phone],
            fax: params[:licensee][:fax],
        )
        redirect_to licensees_path
    end

    def index
        @licensees = Licensee.all
    end
    
    def show
        @licensee = Licensee.find(params[:id])
    end
    
    def edit
        @licensee = Licensee.find(params[:id]) 
    end

    def update
        @licensee = Licensee.find(params[:id])
        @licensee.facility_name = params[:licensee][:facility_name]
        @licensee.contact_name = params[:licensee][:contact_name]
        @licensee.address = params[:licensee][:address]
        @licensee.city = params[:licensee][:city]
        @licensee.state = params[:licensee][:state]
        @licensee.zip = params[:licensee][:zip]
        @licensee.phone = params[:licensee][:phone]
        @licensee.fax = params[:licensee][:fax]
        @licensee.save
        redirect_to licensee_path(params[:id])
    end
    
    def destroy
         @licensee = Licensee.find(params[:id])
         @licensee.destroy
         redirect_to licensees_path
    end
    
    #def self.import(file)
     #   Licensee.import(params[:file])
        
      #  redirect_to root_url, notice: 'Products imported.'
    #end
    
end

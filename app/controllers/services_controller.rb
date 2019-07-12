class ServicesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: %i(new edit destroy)
  
    def new
        @service = Service.new
    end
    
    def create
        Service.create(service_params)
        redirect_to root_path
    end
    
    def index
        
    end
    
    def show
    
    end
    
    def edit
        @service = Service.find(params[:id])
        redirect_to root_path
    end 
    
    def update
    
    end
    
    private
  
    def service_params
      params.require(:service).permit(:name, :prog_code, :age_code)
    end

end

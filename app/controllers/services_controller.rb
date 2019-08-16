class ServicesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: %i(new edit destroy)
  
    def new
        @service = Service.new
        session[:return_to] ||= request.referer
    end
    
    def create
        Service.create(service_params)
        
        if session[:return_to] != nil
            redirect_to session.delete(:return_to)
        else
        redirect_to root_path
        end
    end
    
    def index
        @services = Service.all
    end
    
    def edit
        @service = Service.find(params[:id])
        session[:return_to] ||= request.referer
    end 
    
    def update
        @service = Service.find(params[:id])
        @service.update!(service_params)
        
        if session[:return_to] != nil
            redirect_to session.delete(:return_to)
        else
        redirect_to root_path
        end
    end
    
    def destroy
        @service = Service.find(params[:id])
        @service.destroy
       
        if session[:return_to] != nil
            redirect_to session.delete(:return_to)
        else
            redirect_to root_path
        end
    end
    
    private
  
    def service_params
      params.require(:service).permit(:name, :prog_code, :age_code)
    end

end

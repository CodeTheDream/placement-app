class PlacementsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: [:new, :edit]
    
    require 'roo'
    
    def new
        @placement = Placement.new
        @licensees = Licensee.all
        @services = Service.all
    end
    
    def create
        Placement.create(
            name: params[:placement][:name],
            licensee_id: params[:placement][:licensee_id],
            address: params[:placement][:address],
            city: params[:placement][:city],
            state: params[:placement][:state],
            zip: params[:placement][:zip],
            county: params[:placement][:county],
            phone: params[:placement][:phone],
            gender: params[:placement][:gender],
            beds: params[:placement][:beds],
        )
        redirect_to placements_path
    end
    
    # licensee_id: params[::placement][:licensee_id]
    # service_id: params[:placement][:service_id],    
    
    def index
        search = "%#{params[:search]}%"
        @placements = Placement.where("name LIKE ? OR county LIKE ?" , search, search)
        #respond_to do |format|
        #    format.xlsx {
        #        response.headers[
        #        'Content-Disposition'
        #        ] = "attachment; filename=placements.xlsx"
        #    }
        #    format.html { render :index }
        #end
        @cart_placement = current_cart.cart_placements.new
        @cart = current_cart
        #@order_item = current_order.order_items.new
    end
    
    def show
        @placement = Placement.find(params[:id])
        @licensee = Licensee.find(@placement.licensee_id)
        @comment = Comment.new(placement_id:@placement.id)
        @comments = @placement.comments.collect
    end

    def edit
        @placement = Placement.find(params[:id])
        @licensees = Licensee.all
    end
    
    def update
        @placement = Placement.find(params[:id])
        @placement.name = params[:placement][:name]
        @placement.licensee_id = params[:placement][:licensee_id]
        @placement.address = params[:placement][:address]
        @placement.city = params[:placement][:city]
        @placement.state = params[:placement][:state]
        @placement.zip = params[:placement][:zip]
        @placement.county = params[:placement][:county]
        @placement.phone = params[:placement][:phone]
        @placement.gender = params[:placement][:gender]
        @placement.beds =params[:placement][:beds]
        @placement.save
        redirect_to placement_path(params[:id])
    end
    
    def destroy
        @placement = Placement.find(params[:id])
        @placement.destroy
        redirect_to placements_path 
    end
    
    def comment
        @comment = Comment.new
    end
    
    def placement_params
        params.require(:placement).permit(:name, county, :search)
    end

end

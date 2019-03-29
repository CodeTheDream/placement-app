class CartPlacementsController < ApplicationController
    def new 
        @cart_placement = CartPlacement.new
    end
    
    def index
        @cart_placement = CartPlacement.new
    end
    
    def create
        @cart = current_cart
        @placement = @cart.cart_placements.new(placement_params)
        @cart.save
        @placement.save
        session[:cart_id] = @cart.id
        redirect_to placements_path
    end
    
    def destroy
        @cart = current_cart
        @placement = @cart.cart_placements.find(params[:id])
        @placement.destroy
        @cart_path.save
        redirect_to placements_path
    end
    
    private
    
    def placement_params
        params.require(:cart_placement).permit(:placement_id)
    end

end

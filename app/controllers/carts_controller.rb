class CartsController < ApplicationController
    def show
        @cart = Cart.find(params[:id])
       # @cart_placements = current_cart.cart_placements   
    end
    
    def new
        @cart = Cart.new
        @placements = Placement.all
    end
    
    def add
        @cart = Cart.find(params[:id])
        cart_placement = CartPlacement.new
        cart_placement.placement_id = params[:placment_id]
        cart_placement.cart_id = params[:id]
        cart_placement.save
        redirect_to root_path
    end
    
    def remove
        @cart = Cart.find(params[:id])
        cart_placement = CartPlacement.find(params[:cart_placement_id])
        cart_placement.destroy
        redirect_to root_path
    end
    
    def submit 
        @cart = Cart.find(params[:id])
        @cart.status = 'Submitted'
        @cart.save
        redirect_to root_path
    end
    
end

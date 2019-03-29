class CartsController < ApplicationController
    def show
        @cart = current_cart
        @cart_placements = current_cart.cart_placements   
    end
    
end

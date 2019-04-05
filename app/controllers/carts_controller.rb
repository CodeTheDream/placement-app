# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :create_new_cart
  
  
  def create_new_cart
    if @cart.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
      @cart.status = 'Pending'
      @cart.save
    end
  end
  
  def show
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
  end

  def add
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    cart_placement = CartPlacement.find_by(cart_id: @cart.id, placement_id:
    params[:placement_id])
    if cart_placement.nil?
      cart_placement = CartPlacement.new
      cart_placement.placement_id = params[:placement_id]
      cart_placement.cart_id = @cart.id
      cart_placement.save
    end
  end

  def remove
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    cart_placement = CartPlacement.find(params[:placement_id])
    cart_placement.destroy
    redirect_to cart_path(current_user)
  end

  def submit
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    @cart.status = 'Submitted'
    @cart.save
    redirect_to root_path
  end
end

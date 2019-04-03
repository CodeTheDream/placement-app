# frozen_string_literal: true

class CartsController < ApplicationController

  def show
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
  end

  def add
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    if @cart.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
      @cart.status = 'Pending'
      @cart.save
    end

    cart_placement = CartPlacement.find_by(cart_id: @cart.id, placement_id: params[:placement_id])
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
    redirect_to root_path
  end

  def submit
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    @cart.status = 'Submitted'
    @cart.save
    redirect_to root_path
  end
end

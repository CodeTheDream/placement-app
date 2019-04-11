# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_cart, only: [:show, :add]

  def create_new_cart
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    if @cart.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
      @cart.status = 'Pending'
      @cart.save
    end
  end

  def show
  end

  def add
    cart_placement = CartPlacement.find_by(cart_id: @cart.id, placement_id:
    params[:placement_id])

    if cart_placement.nil?
      cart_placement = CartPlacement.new
      cart_placement.placement_id = params[:placement_id]
      cart_placement.cart_id = @cart.id
      cart_placement.save
      flash[:notice] = "Placement Added to Cart!"
    else
      flash[:alert] = 'Item Not Added. Already in Cart.'
    end
    redirect_to root_path(search: params[:search])
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
  
  def destroy
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.destroy
    redirect_to cart_path(current_user)
  end

  def index
    @cart = Cart.find_by(user_id: current_user.id, status: 'Pending')
    respond_to do |format|
      format.xlsx do
        response.headers[
          'Content-Disposition'
        ] = 'attachment; filename=cart.xlsx'
      end
      format.html { render :index }
    end
  end
  
end

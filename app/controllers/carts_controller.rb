# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_cart, only: [:show, :add]

  def create_new_cart
    @cart = Cart.find_by(user_id: current_user.id)
    if @cart.nil?
      @cart = Cart.new
      @cart.user_id = current_user.id
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
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end
  
  def add_all_to
    
    placement_ids = Placement.find([params[:placement_ids]])
    
    placement_ids.each do |p|
      place = Placement.find_by(id: p)
      
      @cart = Cart.find_by(user_id: current_user.id)
      
      if @cart.nil?
        @cart = Cart.new
        @cart.user_id = current_user.id
        @cart.save
      end
    
      cart_placement = CartPlacement.find_by(cart_id: @cart.id, placement_id: p)
    
      if cart_placement.nil?
        cart_placement = CartPlacement.new
        cart_placement.placement_id = place.id
        cart_placement.cart_id = @cart.id
        cart_placement.save
        flash[:notice] = "Added placements not previously in cart."
      end
    end
    
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  def remove
    @cart = Cart.find_by(user_id: current_user.id)
    cart_placement = CartPlacement.find(params[:placement_id])
    cart_placement.destroy
    redirect_to cart_path(current_user)
  end

  def submit
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.save
    redirect_to root_path
  end
  
  def destroy
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.destroy
    redirect_to cart_path(current_user)
  end

  def index
    @cart = Cart.find_by(user_id: current_user.id)
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

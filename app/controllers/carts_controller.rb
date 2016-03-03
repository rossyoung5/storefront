class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def edit
  end

  def update
  end

  def destroy
    if @cart.destroy
      flash[:notice] = "Cart successfully emptied"
      session[:cart_id] = nil
      redirect_to shop_url
    else
      flash[:alert] = "Sorry Dave, I can't let you do that."
      redirect_to edit_cart_url
    end
  end

end

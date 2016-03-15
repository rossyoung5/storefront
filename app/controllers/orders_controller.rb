class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]
  def new
    if @cart.line_items.empty?
      redirect_to shop_url, notice: "Your cart is empty."
      return
    end

    @order = Order.new

  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      # Move items from cart to order
      @order.add_line_items_from_cart(@cart)

      # Destroy the cart and reset the session cart_id
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil

      # Send confirmation email
      OrderConfirmation.send_order_confirmation(current_user, @order).deliver_now

      # Redirect and confirmation notice
      redirect_to @order, notice: "Thank you for your order!"

    else
      render :new
    end
  end

  def show
    #TODO: deny access to other users' orders
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :payment_type)
  end

end

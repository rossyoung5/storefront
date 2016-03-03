class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  validates_presence_of :shipping_name, :shipping_address, :payment_type

  PAYMENT_TYPES = ["Credit Card", "Paypal", "Bitcoin"]
  validates_inclusion_of :payment_type, in: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def subtotal
    line_items.select("SUM(quantity * price) as sum")[0].sum
  end

  # def tax
  #   subtotal * 0.09
  # end

  def total
    subtotal
    # + tax
  end

end

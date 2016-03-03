class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy


  # def subtotal
  #   line_items.to_a.sum{|item| item.total}
  # end

  #SQL version of summing, faster than Ruby
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

# Finds if product is already in cart
  def add_product(product_id)
    product = Product.find(product_id)
    current_item = line_items.find_by(product_id: product_id)

    #If current_item is there, increase quantity. If not, build new line item
    if current_item
      current_item.quantity += 1
      else
        current_item = line_items.build(product: product, price: product.current_price)
    end

    current_item

  end

end

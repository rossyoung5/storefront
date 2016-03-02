class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy


  # def subtotal
  #   line_items.to_a.sum{|item| item.total}
  # end

  #SQL version of summing, faster than Ruby
  def subtotal
    line_items.select("SUM(quantity * price) as sum")[0].sum
  end

  def tax
    subtotal * 0.09
  end

  def total
    subtotal + tax
  end

end

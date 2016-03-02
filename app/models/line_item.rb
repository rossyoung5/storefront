class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  #TODO before save, reduce product inventory quantity
  #TODO before delete action that updates product inventory quantity (when removed from cart)
end

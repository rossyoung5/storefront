FactoryGirl.define do

  factory :brand do
    name "Sweetness"
  end

  factory :category do
    name "Jackets"
  end

  factory :product do
    name "Thing"
    current_price 10.99
    quantity 10
    description "It's a really cool thing."
    brand
    category
  end

  factory :cart do
  end

end
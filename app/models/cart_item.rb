# app/models/cart_item.rb
class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :product
  end
  
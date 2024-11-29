class Checkout < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :address

  # Add any validation, methods, or callbacks here
  validates :payment_method, :shipping_method, :payment_status, presence: true
end

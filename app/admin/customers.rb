# app/controllers/admin/customers_controller.rb
module Admin
  class CustomersController < ApplicationController
    before_action :authenticate_admin_user! # Ensure admin authentication

    def index
      # Fetch all customers with their associated orders and order details
      @customers = Customer.includes(orders: [:order_items, :province]).where.not(orders: { id: nil })
    end
  end
end

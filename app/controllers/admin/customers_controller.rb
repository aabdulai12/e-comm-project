module Admin
    class CustomersController < ApplicationController
      before_action :authenticate_admin! # Ensure only admins can access this page
  
      def index
        @customers = Customer.includes(orders: :line_items)
      end
    end
  end
  
class OrdersController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @orders = current_user.orders.includes(:line_items, :province)
    end
  end
  
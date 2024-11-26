class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Fetch all orders for the current user, including line items and province for tax details
    @orders = current_user.orders.includes(:line_items, :province)

    # Calculate total tax and total amount for each order
    @orders.each do |order|
      subtotal = order.line_items.sum { |item| item.quantity * item.price }
      
      # Calculate taxes based on the province's tax rates
      gst_amount = subtotal * (order.province.gst || 0)
      pst_amount = subtotal * (order.province.pst || 0)
      hst_amount = subtotal * (order.province.hst || 0)
      
      # Store the tax amounts and total for display
      order.instance_variable_set(:@gst_amount, gst_amount)
      order.instance_variable_set(:@pst_amount, pst_amount)
      order.instance_variable_set(:@hst_amount, hst_amount)
      order.instance_variable_set(:@total_amount, subtotal + gst_amount + pst_amount + hst_amount)
    end
  end
end

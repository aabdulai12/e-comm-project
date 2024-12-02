# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  # Show all orders for the logged-in user
  def index
    @orders = current_user.orders.includes(:order_items, :status).order(created_at: :desc)
  end

  # Show a specific order's details
  def show
    @order = current_user.orders.find(params[:id])
    @province = @order.province
  
  
    @subtotal = @order.order_items.sum { |item| item.quantity * item.price }
    @gst = @subtotal * (@province.gst || 0)
    @pst = @subtotal * (@province.pst || 0)
    @hst = @subtotal * (@province.hst || 0)
    @total = @subtotal + @gst + @pst + @hst
  end
  

  # Mark an order as paid
  def mark_as_paid
    @order = current_user.orders.find(params[:id])
    if @order.update(status: Status.find_by(title: 'paid')) # Ensure a 'paid' status exists
      flash[:success] = "Order has been marked as paid!"
    else
      flash[:error] = "Could not mark the order as paid. Please try again."
    end
    redirect_to orders_path
  end
end

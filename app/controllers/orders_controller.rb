class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items, :status).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @province = @order.province

    if @province.nil?
      flash[:alert] = "Province information is missing for this order."
      redirect_to orders_path and return
    end

    @subtotal = @order.order_items.sum { |item| item.quantity * item.price }
    @gst = @subtotal * (@province.gst || 0)
    @pst = @subtotal * (@province.pst || 0)
    @hst = @subtotal * (@province.hst || 0)
    @total = @subtotal + @gst + @pst + @hst
  end

  def mark_as_paid
    @order = current_user.orders.find(params[:id])
    if @order.update(status: Status.find_or_create_by(title: "paid"))
      flash[:success] = "Order has been marked as paid!"
    else
      flash[:error] = "Could not mark the order as paid. Please try again."
    end
    redirect_to orders_path
  end
end

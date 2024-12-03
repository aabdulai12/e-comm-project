# app/controllers/admin/orders_controller.rb
def update
  @order = Order.find(params[:id])
  if @order.update(order_params)
    redirect_to admin_orders_path, notice: "Order status updated."
  else
    render :edit, alert: "Unable to update the order."
  end
end

  private

def order_params
  params.require(:order).permit(:status)
end

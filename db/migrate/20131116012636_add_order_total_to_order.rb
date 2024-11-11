class AddOrderTotalToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_total, :float
  end
end

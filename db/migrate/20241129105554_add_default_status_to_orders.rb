class AddDefaultStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :status, 'pending'
  end
end

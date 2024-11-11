class AddStatusIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status_id, :integer
  end
end

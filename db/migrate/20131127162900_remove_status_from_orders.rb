class RemoveStatusFromOrders < ActiveRecord::Migration[6.1]
  def up
    remove_column :orders, :status
  end

  def down
    add_column :orders, :status, :string
  end
end

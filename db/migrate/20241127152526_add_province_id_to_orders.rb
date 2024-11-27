class AddProvinceIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :province_id, :integer
  end
end

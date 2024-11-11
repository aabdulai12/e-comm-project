class AddProvinceIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :province_id, :integer
  end
end

class AddTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    # Check if columns exist before adding
    add_column :orders, :gst, :decimal unless column_exists?(:orders, :gst)
    add_column :orders, :pst, :decimal unless column_exists?(:orders, :pst)
    add_column :orders, :hst, :decimal unless column_exists?(:orders, :hst)
  end
end

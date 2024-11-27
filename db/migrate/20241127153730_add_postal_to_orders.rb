class AddPostalToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :postal, :string
  end
end

class AddLineItemIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :line_item_id, :integer
  end
end

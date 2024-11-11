class RemoveLineItemIdFromProducts < ActiveRecord::Migration[6.1]
  def up
    remove_column :products, :line_item_id
  end

  def down
    add_column :products, :line_item_id, :integer
  end
end

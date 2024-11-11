class AddProductIdToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :product_id, :integer
  end
end

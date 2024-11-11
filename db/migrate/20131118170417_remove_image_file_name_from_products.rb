class RemoveImageFileNameFromProducts < ActiveRecord::Migration[6.1]
  def up
    remove_column :products, :image_file_name
  end

  def down
    add_column :products, :image_file_name, :string
  end
end

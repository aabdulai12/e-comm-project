class AddImageFileNameToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :image_file_name, :string
  end
end

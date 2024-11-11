class AddImageToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :image_file_name, :string unless column_exists?(:products, :image_file_name)
    add_column :products, :image_content_type, :string unless column_exists?(:products, :image_content_type)
    add_column :products, :image_file_size, :integer unless column_exists?(:products, :image_file_size)
    add_column :products, :image_updated_at, :datetime unless column_exists?(:products, :image_updated_at)
  end
end

class AddAttachmentImageToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :image_file_name, :string
    add_column :products, :image_content_type, :string
    add_column :products, :image_file_size, :integer
    add_column :products, :image_updated_at, :datetime
  end

  def self.down
    drop_attached_file :products, :image
  end
end

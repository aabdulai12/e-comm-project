class AddAddressFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :province_id, :integer
  end
end

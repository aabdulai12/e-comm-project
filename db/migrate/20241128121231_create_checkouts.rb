class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.references :user, foreign_key: true
      t.references :cart, foreign_key: true
      t.references :address, foreign_key: true
      t.string :payment_method
      t.string :shipping_method
      t.string :payment_status
      t.text :note

      t.timestamps
    end
  end
end

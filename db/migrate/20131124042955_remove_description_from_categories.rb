class RemoveDescriptionFromCategories < ActiveRecord::Migration[6.1]
  def up
    remove_column :categories, :description
  end

  def down
    add_column :categories, :description, :string
  end
end

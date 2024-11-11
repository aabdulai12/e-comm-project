class RemoveContentFromReviews < ActiveRecord::Migration[6.1]
  def up
    remove_column :reviews, :content
  end

  def down
    add_column :reviews, :content, :string
  end
end

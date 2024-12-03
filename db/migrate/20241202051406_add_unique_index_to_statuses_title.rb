class AddUniqueIndexToStatusesTitle < ActiveRecord::Migration[6.1]
  def change
    unless index_exists?(:statuses, :title, unique: true)
      add_index :statuses, :title, unique: true
    end
  end
end

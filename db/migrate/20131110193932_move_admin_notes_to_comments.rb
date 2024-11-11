class MoveAdminNotesToComments < ActiveRecord::Migration[6.1]
  def self.up
    # Specify the index name explicitly based on the error message provided earlier
    remove_index :admin_notes, name: 'index_admin_notes_on_admin_user_type_and_admin_user_id'
    rename_table :admin_notes, :active_admin_comments
    rename_column :active_admin_comments, :admin_user_type, :author_type
    rename_column :active_admin_comments, :admin_user_id, :author_id
    add_column :active_admin_comments, :namespace, :string
    add_index :active_admin_comments, [:namespace]
    add_index :active_admin_comments, [:author_type, :author_id]

    # Update all the existing comments to the default namespace
    say "Updating any existing comments to the #{ActiveAdmin.application.default_namespace} namespace."
    comments_table_name = ActiveRecord::Migrator.proper_table_name("active_admin_comments")
    execute "UPDATE #{comments_table_name} SET namespace='#{ActiveAdmin.application.default_namespace}'"
  end

  def self.down
    remove_index :active_admin_comments, name: 'index_active_admin_comments_on_author_type_and_author_id'
    remove_index :active_admin_comments, name: 'index_active_admin_comments_on_namespace'
    remove_column :active_admin_comments, :namespace
    rename_column :active_admin_comments, :author_id, :admin_user_id
    rename_column :active_admin_comments, :author_type, :admin_user_type
    rename_table :active_admin_comments, :admin_notes
    # Be sure to add back the specific index name if needed
    add_index :admin_notes, [:admin_user_type, :admin_user_id], name: 'index_admin_notes_on_admin_user_type_and_admin_user_id'
  end
end

class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :author, :boolean, :default => false
    add_column :users, :viewer, :boolean, :default => false
    add_column :users, :destroyer, :boolean, :default => false
    add_column :users, :commenter, :boolean, :default => false
    add_column :users, :editor, :boolean, :default => false
  end
end

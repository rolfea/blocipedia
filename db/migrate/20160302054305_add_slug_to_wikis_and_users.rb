class AddSlugToWikisAndUsers < ActiveRecord::Migration
  def change
    add_column :wikis, :slug, :string
    add_column :users, :slug, :string
    add_index :wikis, :slug, unique: true
    add_index :users, :slug, unique: true
  end
end

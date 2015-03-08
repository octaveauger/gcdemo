class IndexSlugs < ActiveRecord::Migration
  def change
    add_index :admins, :slug
    add_index :merchants, :slug
  end
end

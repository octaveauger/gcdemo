class AddSlugToUser < ActiveRecord::Migration
  def change
  	add_column :admins, :slug, :string
  end
end

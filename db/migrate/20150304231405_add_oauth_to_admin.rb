class AddOauthToAdmin < ActiveRecord::Migration
  def change
  	add_column :admins, :provider, :string
    add_column :admins, :uid, :string
  end
end

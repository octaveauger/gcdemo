class AddEncryptionToApiDetails < ActiveRecord::Migration
  def change
  	add_column :merchants, :encrypted_api_id, :string
  	add_column :merchants, :encrypted_api_key, :string
  end
end

class AddingBacsComplianceFields < ActiveRecord::Migration
  def change
  	add_column :customers, :single_signatory, :boolean
  	add_column :customers, :holder_name, :string
  	add_column :merchants, :phone, :string
  	add_column :merchants, :email, :string
  end
end

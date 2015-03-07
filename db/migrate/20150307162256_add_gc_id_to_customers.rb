class AddGcIdToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :gc_customer_id, :string
  end
end

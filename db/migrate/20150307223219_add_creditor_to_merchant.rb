class AddCreditorToMerchant < ActiveRecord::Migration
  def change
  	add_column :merchants, :gc_creditor_id, :string
  end
end

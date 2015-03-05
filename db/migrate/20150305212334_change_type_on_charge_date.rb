class ChangeTypeOnChargeDate < ActiveRecord::Migration
  def change
  	change_column :payment_templates, :charge_date, :int
  end
end

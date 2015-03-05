class CreatePaymentTemplates < ActiveRecord::Migration
  def change
    create_table :payment_templates do |t|
      t.references :merchant, index: true
      t.float :amount_gbp
      t.float :amount_eur
      t.date :charge_date
      t.string :reference

      t.timestamps
    end
  end
end

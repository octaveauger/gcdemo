class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :mandate, index: true
      t.string :gc_payment_id

      t.timestamps
    end
  end
end

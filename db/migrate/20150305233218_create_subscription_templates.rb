class CreateSubscriptionTemplates < ActiveRecord::Migration
  def change
    create_table :subscription_templates do |t|
      t.references :merchant, index: true
      t.string :name
      t.float :amount_gbp
      t.float :amount_eur
      t.integer :day_of_month
      t.string :interval_unit
      t.integer :interval

      t.timestamps
    end
  end
end

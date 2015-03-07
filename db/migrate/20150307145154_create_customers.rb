class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.references :merchant, index: true
      t.string :address_line1
      t.string :address_line2
      t.string :address_line3
      t.string :city
      t.string :country_code
      t.string :postal_code
      t.string :email
      t.string :family_name
      t.string :given_name

      t.timestamps
    end
  end
end

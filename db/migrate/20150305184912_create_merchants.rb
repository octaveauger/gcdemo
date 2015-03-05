class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.references :admin, index: true
      t.string :name
      t.string :mandate_name
      t.string :address1
      t.string :postcode
      t.string :city
      t.string :api_id
      t.string :api_key
      t.string :logo
      t.string :product_image

      t.timestamps
    end

    add_index :merchants, :name
  end
end

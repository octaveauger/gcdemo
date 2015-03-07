class CreateMandates < ActiveRecord::Migration
  def change
    create_table :mandates do |t|
      t.references :bank_account, index: true
      t.string :reference
      t.string :gc_mandate_id

      t.timestamps
    end
  end
end

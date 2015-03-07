class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :customer, index: true
      t.string :iban
      t.string :account_number
      t.string :bank_code
      t.string :branch_code
      t.string :gc_bank_account_id

      t.timestamps
    end
  end
end

class AddEncryptionToIban < ActiveRecord::Migration
  def change
  	add_column :bank_accounts, :encrypted_iban, :string
  	add_column :bank_accounts, :encrypted_account_number, :string
  	add_column :bank_accounts, :encrypted_bank_code, :string
  	add_column :bank_accounts, :encrypted_branch_code, :string
  end
end

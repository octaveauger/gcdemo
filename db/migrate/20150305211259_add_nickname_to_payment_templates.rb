class AddNicknameToPaymentTemplates < ActiveRecord::Migration
  def change
  	add_column :payment_templates, :nickname, :string
  end
end

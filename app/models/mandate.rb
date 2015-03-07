class Mandate < ActiveRecord::Base
  belongs_to :bank_account

  def create_gc_mandate
  	return true unless self.bank_account.mandates.count == 0
	begin
		result = self.bank_account.customer.merchant.client.mandate.create(body: {
			mandates: {
				links: {
					creditor: self.bank_account.customer.merchant.gc_creditor_id,
					customer_bank_account: self.bank_account.gc_bank_account_id
				}
			}
		})
		self.gc_mandate_id = result[:id]
		self.reference = result[:reference]
		self.save!
		true
	rescue Atum::Core::ApiError => atum_error
		atum_error.error[:message]
	end
  end
end

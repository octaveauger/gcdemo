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

  def generate_pdf
	response = Typhoeus.post(
		'https://api-sandbox.gocardless.com/helpers/mandate',
		headers: {
			'Authorization' => 'Basic ' + Base64.strict_encode64(self.bank_account.customer.merchant.api_id + ':' + self.bank_account.customer.merchant.api_key),
			'GoCardless-Version' => '2014-11-03',
			'Content-Type' => 'application/json',
			'Accept' => 'application/pdf',
			'Accept-Language' => 'en'
		},
		body: {
			country_code: 'gb',
			scheme: 'bacs'
		}
	)
	response
  end
end

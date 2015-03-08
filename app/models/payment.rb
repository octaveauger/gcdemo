class Payment < ActiveRecord::Base
  belongs_to :mandate

  def self.generate_payments(customer)
  	customer.merchant.payment_templates.all.each do |template|
  		@result = customer.bank_accounts.first.mandates.first.payments.new.create_gc_payment(template)
  		break if !(@result === true)
  	end
  	@result
  end

  def create_gc_payment(template)
	begin
		if self.mandate.bank_account.customer.country_code == "GB"
			amount = template.amount_gbp * 100
			currency = 'GBP'
		else
			amount = template.amount_eur * 100
			currency = 'EUR'			
		end
		options = {}
		options.merge!({ reference: template.reference }) unless template.reference.blank?
		options.merge!({ charge_date: (Time.now + template.charge_date.to_i.days).strftime("%Y-%m-%d") }) unless template.charge_date.blank?

		result = self.mandate.bank_account.customer.merchant.client.payment.create(body: {
			payments: options.merge!({
				amount: amount.to_i,
				currency: currency,
				links: {
					mandate: self.mandate.gc_mandate_id
				}
			})
		})
		self.gc_payment_id = result[:id]
		self.save!
		true		
	rescue Atum::Core::ApiError => atum_error
		atum_error.error[:message]
	end
  end
end

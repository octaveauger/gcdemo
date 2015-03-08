class Subscription < ActiveRecord::Base
  belongs_to :mandate

  def self.generate_subscriptions(customer)
  	customer.merchant.subscription_templates.all.each do |template|
  		@result = customer.bank_accounts.first.mandates.first.subscriptions.new.create_gc_subscription(template)
  		break if !(@result === true)
  	end
  	@result
  end

  def create_gc_subscription(template)
	begin
		if self.mandate.bank_account.customer.country_code == "GB"
			amount = template.amount_gbp * 100
			currency = 'GBP'
		else
			amount = template.amount_eur * 100
			currency = 'EUR'			
		end
		options = {}
		options.merge!({ name: template.name }) unless template.name.blank?
		options.merge!({ day_of_month: template.day_of_month }) unless template.interval_unit != 'monthly'

		result = self.mandate.bank_account.customer.merchant.client.subscription.create(body: {
			subscriptions: options.merge!({
				amount: amount.to_i,
				currency: currency,
				interval: template.interval,
				interval_unit: template.interval_unit,
				links: {
					mandate: self.mandate.gc_mandate_id
				}
			})
		})
		self.gc_subscription_id = result[:id]
		self.save!
		true		
	rescue Atum::Core::ApiError => atum_error
		atum_error.error[:message]
	end
  end
end

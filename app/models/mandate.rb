class Mandate < ActiveRecord::Base
  belongs_to :bank_account
  has_many :payments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

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
		I18n.t('gocardless.mandate_error') + atum_error.error[:message]
	end
  end

  def generate_pdf
  	return if File.exists?(tmp_pdf_path)

	tmp_file = File.open(tmp_pdf_path, 'wb')
	request = Typhoeus::Request.new(
		'https://api-sandbox.gocardless.com/mandates/' + self.gc_mandate_id,
		headers: {
			'Authorization' => 'Basic ' + Base64.strict_encode64(self.bank_account.customer.merchant.api_id + ':' + self.bank_account.customer.merchant.api_key),
			'GoCardless-Version' => '2014-11-03',
			'Content-Type' => 'application/json',
			'Accept' => 'application/pdf',
			'Accept-Language' => I18n.locale
		}
	)
	request.on_body { |chunk| tmp_file.write(chunk) }
	request.on_complete do |response|
		tmp_file.close
		raise "Error" unless response.code == 200
	end
	request.run
  end

  def tmp_pdf_path
  	Rails.root.join("tmp", "#{gc_mandate_id}.pdf")
  end
end

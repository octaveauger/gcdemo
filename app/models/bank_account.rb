class BankAccount < ActiveRecord::Base
  belongs_to :customer
  has_many :mandates, dependent: :destroy

  validate :has_bank_details

  attr_encrypted :iban, key: 'fh4fjeifj48uf£284jeojfFejfuehk48'
  attr_encrypted :account_number, key: 'D$RYFHOIHD43hfioHFiu4ubf'
  attr_encrypted :bank_code, key: '$(JFOPRNJ)(£U*FNP£UNR£HFO'
  attr_encrypted :branch_code, key: 'DIOJ£U()FUNR£(J)RN£F£I(UR*FN£('

  def iban_obfuscated
  	hidden = self.iban.gsub(/\s+/, "")[-4..-1]
	hidden.rjust(18, '*')
  end

  def account_number_obfuscated
  	hidden = self.account_number.gsub(/\s+/, "")[-3..-1]
	hidden.rjust(8, '*')
  end

  # This is used as a temporary fix to determine based on the customer's country which scheme we should follow for compliance
  # This is not used to create the mandate - the scheme is automatically determined on GoCardless' side
  def scheme
  	if self.customer.country_code == 'GB'
  		'bacs'
  	else
  		'sepa_core'
  	end
  end

  def create_gc_bank_account
  	return true unless self.gc_bank_account_id.blank?
	begin
		if self.iban.blank?
			options = {
				account_number: self.account_number,
				bank_code: self.bank_code,
				branch_code: self.branch_code,
				country_code: self.customer.country_code
			}
		else
			options = {
				iban: self.iban
			}
		end

		result = self.customer.merchant.client.customer_bank_account.create(body: {
			customer_bank_accounts: options.merge({
				account_holder_name: self.customer.full_name,
				links: {
					customer: self.customer.gc_customer_id
				}
			})
		})
		self.update_attributes(gc_bank_account_id: result[:id])
		true
	rescue Atum::Core::ApiError => atum_error
		'GoCardless Bank Account Error: ' + atum_error.error[:message]
	end
end

private

	# Checks that there are either IBAN or local bank details
	def has_bank_details
    if self.iban.blank?
			case self.customer.country_code
      when 'GB'
        if self.account_number.blank? or self.branch_code.blank?
			    errors.add(:account_number, "you need to enter your account number and sort code")
        end
      when 'FR'
        if self.account_number.blank? or self.branch_code.blank? or self.bank_code.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      when 'BE'
         if self.account_number.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      when 'DE'
         if self.account_number.blank? or self.bank_code.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      when 'ES'
         if self.account_number.blank? or self.branch_code.blank? or self.bank_code.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      when 'IT'
         if self.account_number.blank? or self.branch_code.blank? or self.bank_code.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      when 'NL'
        if self.account_number.blank? or self.bank_code.blank?
          errors.add(:account_number, "you need to enter your IBAN or local bank details")
        end
      else
        errors.add(:country_code, "unknown country")
      end
		end
	end

end

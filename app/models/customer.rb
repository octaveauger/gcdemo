class Customer < ActiveRecord::Base
  belongs_to :merchant
  has_many :bank_accounts, dependent: :destroy
  accepts_nested_attributes_for :bank_accounts
  
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :country_code, presence: true
  validates :email, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true

  def full_name
  	self.given_name + ' ' + self.family_name
  end

  def full_address
	address = self.address_line1
	address += self.address_line2 == '' ? '' : ', ' + self.address_line2
	address += self.address_line3 == '' ? '' : ', ' + self.address_line3
	address += ', ' + self.postal_code + ' ' + self.city
	address
  end

  def create_gc_customer
  	return true unless self.gc_customer_id.blank?
  	begin
		result = self.merchant.client.customer.create(body: {
			customers: {
				given_name: self.given_name,
				family_name: self.family_name,
				email: self.email,
				address_line1: self.address_line1,
				address_line2: self.address_line2,
				address_line3: self.address_line3,
				postal_code: self.postal_code,
				city: self.city,
				country_code: self.country_code,
			}
		})
		self.update_attributes(gc_customer_id: result[:id])
		true
	rescue Atum::Core::ApiError => atum_error
		atum_error.error[:message]
	end
  end
end

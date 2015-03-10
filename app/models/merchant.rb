class Merchant < ActiveRecord::Base
  belongs_to :admin
  has_many :payment_templates, dependent: :destroy
  has_many :subscription_templates, dependent: :destroy
  has_many :customers, dependent: :destroy

  before_validation :get_gc_creditor_id
  before_validation :add_slug

  attr_encrypted :api_id, key: 'DJ£UJ£UR£JFIEKDIjdu3kd93ud@3u'
  attr_encrypted :api_key, key: 'FD93k@$*PD39uf0930i0I02I-3[DJ'

  default_scope { order('created_at DESC') }

  mount_uploader :logo, ImageUploader
  mount_uploader :product_image, ImageUploader
  validate :image_size
  validates :name, presence: true
  validate :unique_name
  validates :mandate_name, presence: true
  validates :address1, presence: true
  validates :postcode, presence: true
  validates :city, presence: true
  validates :api_id, presence: true
  validates :api_key, presence: true
  validates :logo, presence: true
  validates :gc_creditor_id, presence: true

  def add_slug
    self.slug = self.name.parameterize
  end

  def full_address
    self.address1 + ', ' + self.postcode + ' ' + self.city
  end

  def client
    @client ||= generate_client
  end

  private

  	# Validates the size of an uploaded image
  	def image_size
  		if logo.size > 5.megabytes
  			errors.add(:logo, "should be less than 5MB")
  		end
  		if product_image.size > 5.megabytes
  			errors.add(:product_image, "should be less than 5MB")
  		end
  	end

    def unique_name
      if self.id.nil? # new merchant being created
        merchants = Merchant.where('admin_id = ? AND slug = ?', self.admin_id, self.slug)
      else # existing merchant being updated
        merchants = Merchant.where('admin_id = ? AND slug = ? AND id != ?', self.admin_id, self.slug, self.id)
      end
      errors.add(:name, "must be unique amongst all merchants in your account") unless merchants.count == 0
    end

    # Enables the possibility to use different clients rather than the singleton from the GoCardless Ruby client
    def generate_client
      options = GoCardless::Enterprise.custom_options(options)
      uri = URI.parse('https://api-sandbox.gocardless.com/')
      uri.user = self.api_id.gsub('@', '%40')
      uri.password = self.api_key
      client = Atum::Core::Client.client_from_schema(GoCardless::Enterprise::SCHEMA, uri.to_s, options)
      GoCardless::Enterprise::Client.new(client)
    end

    def get_gc_creditor_id
      if self.api_id.blank? or self.api_key.blank?
        errors.add(:api_id, 'Issue with API connection')
      else
        begin
          result = client.creditor.list
          self.gc_creditor_id = result.first[:id]
          true
        rescue Atum::Core::ApiError => atum_error
          errors.add(:api_id, 'Issue with API connection: ' + atum_error.error[:message])
        end
      end
    end
end

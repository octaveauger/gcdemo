class Merchant < ActiveRecord::Base
  belongs_to :admin

  mount_uploader :logo, ImageUploader
  mount_uploader :product_image, ImageUploader
  validate :image_size
  validates :name, presence: true
  validates :mandate_name, presence: true
  validates :address1, presence: true
  validates :postcode, presence: true
  validates :city, presence: true
  validates :api_id, presence: true
  validates :api_key, presence: true
  validates :logo, presence: true

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
end

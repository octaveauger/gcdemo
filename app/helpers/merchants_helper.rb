module MerchantsHelper

	def current_merchant
		@current_merchant ||= Merchant.find_by(slug: params[:merchant_slug])
	end

	def existing_merchant
		admin = Admin.find_by(slug: params[:admin_slug])
		if !admin.nil?
			merchant = admin.merchants.find_by(slug: params[:merchant_slug])
		end
		if admin.nil? or merchant.nil?
			flash['notice'] = "The link you entered doesn't exist"
			redirect_to root_path
		end
	end
end

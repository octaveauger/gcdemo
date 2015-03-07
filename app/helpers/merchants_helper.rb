module MerchantsHelper

	def current_merchant
		@current_merchant ||= Merchant.find_by(id: params[:merchant_id])
	end

	def existing_merchant
		admin = Admin.find_by(id: params[:admin_id])
		if !admin.nil?
			merchant = admin.merchants.find_by(id: params[:merchant_id])
		end
		if admin.nil? or merchant.nil?
			flash['notice'] = "The link you entered doesn't exist"
			redirect_to root_path
		end
	end
end

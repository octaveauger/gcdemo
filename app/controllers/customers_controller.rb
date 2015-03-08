class CustomersController < ApplicationController
  before_action :existing_merchant

  layout 'demo'

  def new
  	@customer = current_merchant.customers.new
  	@customer.bank_accounts.build
  end

  def create
  	@customer = current_merchant.customers.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to flow_representation_path(current_merchant.admin.slug, current_merchant.slug)
    else
      flash[:alert] = 'Your details contain errors'
      render 'new'
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:merchant_id, :given_name, :family_name, :email, :address_line1, :address_line2, :address_line3, :postal_code, :city, :country_code, bank_accounts_attributes: [:id, :iban, :account_number, :bank_code, :branch_code])
    end
end

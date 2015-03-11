class FlowController < ApplicationController
  before_action :existing_merchant

  layout 'demo'

  def home
  end

  def representation
  end

  def confirmation
  	result = current_customer.create_gc_customer
  	if result === true
  		result = current_customer.bank_accounts.first.create_gc_bank_account
  	end
  	if result === true
  		result = current_customer.bank_accounts.first.mandates.new.create_gc_mandate
  	end
  	if result === true and current_customer.bank_accounts.first.mandates.first.payments.count == 0
  		result = Payment.generate_payments(current_customer)
  	end
  	if result === true and current_customer.bank_accounts.first.mandates.first.subscriptions.count == 0
  		result = Subscription.generate_subscriptions(current_customer)
  	end
  	if !(result === true)
  		flash[:alert] = result
  		redirect_to new_customer_path(current_merchant.admin.slug, current_merchant.slug)
  	end
  end

  def pdf
    mandate = current_customer.bank_accounts.first.mandates.first
    mandate.generate_pdf

  	send_file(mandate.tmp_pdf_path, filename: "mandate.pdf", disposition: 'inline', type: "application/pdf")
  end
end

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
  	flash[:notice] = result unless result === true
  end

  def pdf
  	@res = current_customer.bank_accounts.first.mandates.first.generate_pdf
  	#send_file(current_customer.bank_accounts.first.mandates.first.generate_pdf, :filename => "mandate.pdf", :disposition => 'inline', :type => "application/pdf")
  end
end
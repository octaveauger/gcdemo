class PaymentTemplatesController < ApplicationController
  before_action :logged_in_admin
  before_action :admin_owns_merchant

  def index
    @payments = current_merchant.payment_templates.all.paginate(page: params[:page])
  end

  def new
    @payment = current_merchant.payment_templates.new
  end

  def create
    @payment = current_merchant.payment_templates.new(payment_params)
    if @payment.save
      flash[:notice] = 'New payment template created!'
      redirect_to merchant_payment_templates_path
    else
      flash[:alert] = 'Your new payment template contains errors'
      render 'new'
    end
  end

  def edit
    @payment = current_merchant.payment_templates.find_by(id: params[:id])
    if @payment.nil?
      flash[:alert] = "This payment template wasn't found"
      redirect_to merchant_payment_templates_path
    end
  end

  def update
    @payment = current_merchant.payment_templates.find_by(id: params[:id])
    if(@payment.update_attributes(payment_params))
      flash[:notice] = 'Payment template successfully updated'
      redirect_to merchant_payment_templates_path
    else
      flash[:alert] = 'There were errors while updating this payment template'
      render 'edit'
    end
  end

  def destroy
    current_merchant.payment_templates.find(params[:id]).destroy
    flash[:notice] = 'payment template deleted'
    redirect_to merchant_payment_templates_path
  end

  private

    def admin_owns_merchant
      if !params[:merchant_id] || current_admin.merchants.find_by(id: params[:merchant_id]).nil?
        redirect_to merchants_path, notice: "This merchant does not exist or you cannot access it"
      end
    end

    def payment_params
      params.require(:payment_template).permit(:merchant_id, :amount_gbp, :amount_eur, :charge_date, :reference, :nickname)
    end

    def current_merchant
      Merchant.find(params[:merchant_id])
    end
end

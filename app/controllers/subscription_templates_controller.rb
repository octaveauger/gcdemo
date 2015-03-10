class SubscriptionTemplatesController < ApplicationController
  before_action :logged_in_admin
  before_action :admin_owns_merchant

  def index
    @subscriptions = current_merchant.subscription_templates.all.paginate(page: params[:page])
  end

  def new
    @subscription = current_merchant.subscription_templates.new
  end

  def create
    @subscription = current_merchant.subscription_templates.new(subscription_params)
    if @subscription.save
      flash[:notice] = 'New subscription template created!'
      if params[:commit].downcase.include? 'next'
        redirect_to merchants_path
      else
        redirect_to new_merchant_subscription_template_path
      end
    else
      flash[:alert] = 'Your new subscription template contains errors'
      render 'new'
    end
  end

  def edit
    @subscription = current_merchant.subscription_templates.find_by(id: params[:id])
    if @subscription.nil?
      flash[:alert] = "This subscription template wasn't found"
      redirect_to merchant_subscription_templates_path
    end
  end

  def update
    @subscription = current_merchant.subscription_templates.find_by(id: params[:id])
    if(@subscription.update_attributes(subscription_params))
      flash[:notice] = 'Subscription template successfully updated'
      redirect_to merchant_subscription_templates_path
    else
      flash[:alert] = 'There were errors while updating this subscription template'
      render 'edit'
    end
  end

  def destroy
    current_merchant.subscription_templates.find(params[:id]).destroy
    flash[:notice] = 'subscription template deleted'
    redirect_to merchant_subscription_templates_path
  end

  private

    def admin_owns_merchant
      if !params[:merchant_id] || current_admin.merchants.find_by(id: params[:merchant_id]).nil?
        redirect_to merchants_path, notice: "This merchant does not exist or you cannot access it"
      end
    end

    def subscription_params
      params.require(:subscription_template).permit(:merchant_id, :name, :amount_gbp, :amount_eur, :day_of_month, :interval_unit, :interval)
    end

    def current_merchant
      Merchant.find(params[:merchant_id])
    end
end

class MerchantsController < ApplicationController
  before_action :logged_in_admin

  def index
    @merchants = Merchant.all.paginate(page: params[:page])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:notice] = 'New merchant created!'
      redirect_to merchants_path
    else
      flash[:alert] = 'Your new merchant contains errors'
      render 'new'
    end
  end

  def edit
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.nil?
      flash[:alert] = "This merchant wasn't found"
      redirect_to merchants_path
    end
  end

  def update
    @merchant = Merchant.find_by(id: params[:id])
    if(@merchant.update_attributes(merchant_params))
      flash[:notice] = 'Merchant successfully updated'
      redirect_to merchants_path
    else
      flash[:alert] = 'There were errors while updating this merchant'
      render 'edit'
    end
  end

  def destroy
    Merchant.find(params[:id]).destroy
    flash[:notice] = 'Merchant deleted'
    redirect_to merchants_path
  end

  private

    def merchant_params
      params.require(:merchant).permit(:admin_id, :name, :mandate_name, :address1, :postcode, :city, :api_id, :api_key, :logo, :product_image)
    end
end

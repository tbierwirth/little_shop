class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to '/merchants'
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    redirect_to "/merchants/#{@merchant.id}"
  end

  def destroy
    @merchant = Merchant.find(params[:id])
    @contents = session[:cart]
    if Merchant.can_destroy?(@merchant)
      Merchant.destroy(params[:id])
      redirect_to '/merchants'
    else
      flash[:notice] = "This merchant can not be deleted. One or more items from this merchant is in an order."
      render :show
    end
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end

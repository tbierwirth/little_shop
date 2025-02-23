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
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:notice] = "Creation Sucessful!"
      redirect_to '/merchants'
    else
      flash[:merchant_error] = @merchant.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update_attributes(merchant_params)
    if @merchant.save
      flash[:notice] = "Update Sucessful!"
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash[:merchant_error] = @merchant.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @merchant = Merchant.find(params[:id])
    @contents = session[:cart]
    if @merchant.can_destroy?
      if @contents.present?
        @merchant.items.each do |item|
          @contents.delete(item.id.to_s)
        end
      end
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

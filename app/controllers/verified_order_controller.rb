class VerifiedOrderController < ApplicationController

  def show
    @order = Order.where(verification_code: code["Search"]).first

  end

  def edit
    @order = Order.find(params[:verified_order_id])
  end

  def update
    @order = Order.find(params[:verified_order_id])
    @order.update_attributes(merchant_params)
    render :show
  end

  def destroy
    @order = Order.find(params[:verified_order_id])
    Order.destroy(params[:verified_order_id])
    flash[:notice] = "Order #{@order.id} has been deleted"
    redirect_to '/'
  end

private
  def code
    params.permit("Search")
  end

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end

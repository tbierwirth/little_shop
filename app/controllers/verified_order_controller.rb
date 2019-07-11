class VerifiedOrderController < ApplicationController

  def show
    @order = Order.where(verification_code: code["Search"]).first
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

end

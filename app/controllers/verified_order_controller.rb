class VerifiedOrderController < ApplicationController

  def show
    @order = Order.where(verification_code: code["Search"]).first
  end

  def destroy
    Order.destroy(params[:verified_order_id])
    flash[:notice] = "Your order has been deleted."
    redirect_to '/'
  end

private
  def code
    params.permit("Search")
  end

end

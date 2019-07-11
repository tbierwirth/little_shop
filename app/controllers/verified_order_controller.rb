class VerifiedOrderController < ApplicationController

  def show
    @order = Order.where(verification_code: code["Search"]).first
  end

private
  def code
    params.permit("Search")
  end

end

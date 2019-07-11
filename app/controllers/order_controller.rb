class OrderController < ApplicationController

  def new
    @contents = session[:cart]
    @cart_contents = []
    @contents.each do |item, quantity|
      @cart_contents.push(Item.find(item))
    end
  end

  def create
    @order = Order.new(order_params)
    @contents = session[:cart]
    if @order.save && (@order.zip.class == Integer) && (@order.zip.digits.length == 5)
      @contents.each do |item, quantity|
        ItemOrder.create(order_id: @order.id,
          item_id: item,
          quantity: quantity,
          price: Item.find(item).price)
      end
      @order.generate_verification_code
      flash[:notive] = "Your order ID is #{@order.verification_code}"
      redirect_to "/order/#{@order.id}"
      reset_session
    else
      flash[:notice] = "Please complete all shipping info"
      redirect_to order_new_path
    end
  end

  def show
    @order = Order.find(params[:order_id])
    @item_orders = @order.item_orders
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end

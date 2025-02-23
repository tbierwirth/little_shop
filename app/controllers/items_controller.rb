class ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews
    @top_three = @item.top_three_rated
    @bottom_three = @item.bottom_three_rated
    @average_rate = @item.average_rating
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:notice] = "Creation Sucessful!"
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:item_error] = @item.errors.full_messages.join(", ")
      render :new
    end

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:notice] = "Update Sucessful!"
      redirect_to "/items/#{@item.id}"
    else
      flash[:item_error] = @item.errors.full_messages.join(", ")
      render :edit
    end

  end

  def destroy
    @item = Item.find(params[:id])
    @contents = session[:cart]
    if @item.can_destroy?
      if @contents.present?
        @contents.delete(@item.id.to_s)
      end
      Item.destroy(params[:id])
      redirect_to '/items'
    else
      flash[:notice] = "This item can not be deleted, it is currently being ordered."
      redirect_to "/items/#{@item.id}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end

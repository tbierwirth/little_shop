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
    @top_three = Review.top_three_rated(@item)
    @bottom_three = Review.bottom_three_rated(@item)
    @average_rate = Review.average_rating(@item)
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
    Item.destroy(params[:id])

    redirect_to '/items'
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end

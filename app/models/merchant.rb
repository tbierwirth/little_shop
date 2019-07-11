class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def count_items
    items.count
  end

  def avg_price_items
    items.average(:price)
  end

  def cities_ordered
    items.joins(:orders).distinct.pluck(:city).join(", ")
  end

  def can_destroy?
    Merchant.joins(items: [:item_orders]).where(id: self.id).empty?
  end



  # def self.top_rated_items(merchant)
  #   @count = merchant.count_items
  #   incrementer = 0
  #   Merchant.select('item.id').joins(:item).all
  #     .all
  #     @item_ids = Merchant.find(merchant.id).items.all.group(:id)
  #
  #
  #
  #   while incrementer < @count
  #       @items << Merchant.find(merchant.id).items.find().reviews.sum(:rating)
  #       incrementer += 1
  #   end
  end

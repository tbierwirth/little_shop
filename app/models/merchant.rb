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
    Merchant.joins(items: [:item_orders]).empty?
  end

end

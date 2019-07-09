class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  def can_destroy?
    Item.joins(:item_orders).empty?
  end
  
end

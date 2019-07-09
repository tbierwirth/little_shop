class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def self.can_destroy?(merchant)
    answer = ItemOrder.all.map do |item|
      Item.find(item.item_id).merchant_id == merchant.id
    end
    answer == (false || [])
  end

end

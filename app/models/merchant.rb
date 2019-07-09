class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.can_destroy?(merchant)
    answer = ItemOrder.all.map do |item|
      Item.find(item.item_id).merchant_id == merchant.id
    end
    answer == (false || [])
  end

end

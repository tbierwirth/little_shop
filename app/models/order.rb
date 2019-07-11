class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders

  def generate_verification_code
    update(verification_code: 10.times.map{rand(10)}.join.to_i)
  end
end

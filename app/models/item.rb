class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price
  validates_presence_of :image
  validates_presence_of :inventory

  def can_destroy?
    Item.joins(:item_orders).where(id: self.id).empty?
  end

  def top_three_rated
    reviews.order(rating: :desc).limit(3)
  end

  def bottom_three_rated
    reviews.order(rating: :asc).limit(3)
  end

  def average_rating
    reviews.average(:rating)
  end

end

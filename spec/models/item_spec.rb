require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many(:item_orders)}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe 'Class Methods' do
    it "can_destroy? returns false" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order = Order.create!(name: "Bill", address: "123", city: "Denver", state: "CO", zip: "80210")
      ItemOrder.create!(order_id: @order.id, item_id: @hippo.id, quantity: 1, price: @hippo.price)

      expect(@hippo.can_destroy?).to be false
    end

    it "#top_three_rated, #bottom_three_rated, #average_rating - Reviews" do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
      @review2 = @giant.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
      @review3 = @giant.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")
      @review4 = @giant.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      top_three = [@review1, @review4, @review3]
      expect(@giant.top_three_rated).to eq(top_three)

      bottom_three = [@review2, @review3, @review4]
      expect(@giant.bottom_three_rated).to eq(bottom_three)

      expect(@giant.average_rating).to eq(3.25)
    end


  end
end

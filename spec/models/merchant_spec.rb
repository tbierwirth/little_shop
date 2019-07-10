require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe 'Class Methods' do
    it "can_destroy? returns false" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order = Order.create!(name: "Bill", address: "123", city: "Denver", state: "CO", zip: "80210")
      ItemOrder.create!(order_id: @order.id, item_id: @hippo.id, quantity: 1, price: @hippo.price)

      expect(Merchant.can_destroy?(@brian)).to be false
    end

    it "#count_items" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @ogre = @brian.items.create!(name: 'Ogre', description: "I'm a Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @unicorn= @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 200, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )
      @order = Order.create!(name: "Bill", address: "123", city: "Denver", state: "CO", zip: "80210")
      expect(@brian.count_items).to eq(3)
    end

    it "#avg_price_items" do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @ogre = @brian.items.create!(name: 'Ogre', description: "I'm a Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @unicorn= @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 200, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )
      @order = Order.create!(name: "Bill", address: "123", city: "Denver", state: "CO", zip: "80210")

      expect(@brian.avg_price_items).to eq(90)
    end

    it "#cities_ordered" do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order1 = Order.create!(name: 'PaulieP', address: 'yo yo st', city: 'Denver', state: 'CO', zip: 80218)
      @order2 = Order.create!(name: 'Kanye', address: 'Lime Lite st', city: 'Chicago', state: 'IL', zip: 90210)
      @order3 = Order.create!(name: 'Me', address: 'yo yo st', city: 'Denver', state: 'CO', zip: 90210)
      @item_order1 = @giant.item_orders.create!(order_id: @order1.id, item_id: @giant.id, quantity: 2, price: @giant.price)
      @item_order2 = @ogre.item_orders.create!(order_id: @order2.id, item_id: @ogre.id, quantity: 3, price: @ogre.price)
      @item_order3 = @ogre.item_orders.create!(order_id: @order3.id, item_id: @ogre.id, quantity: 4, price: @ogre.price)

      expect(@megan.cities_ordered).to eq("Chicago, Denver")
    end

  end

end

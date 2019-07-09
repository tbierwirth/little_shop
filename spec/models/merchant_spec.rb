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

  end

end

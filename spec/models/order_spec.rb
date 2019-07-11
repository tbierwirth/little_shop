require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it {should have_many(:item_orders)}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'Class Methods' do
    it "generate_verification_code" do
      order = Order.create(name: "Bill", address: "123", city: "Denver", state: "CO", zip: "80210")
      order.generate_verification_code
      allow(order).to receive(:generate_verification_code) { |params| params[:verification_code] }
    end
  end
end

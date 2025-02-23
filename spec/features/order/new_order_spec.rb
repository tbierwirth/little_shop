require 'rails_helper'

RSpec.describe "As a vistor" do
  describe "When I checkout from my cart" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      visit '/items'

      click_on "Ogre"
      click_on "Add To Cart"

      click_on "Ogre"
      click_on "Add To Cart"

      click_on "Giant"
      click_on "Add To Cart"

      visit '/cart'
      click_on 'Checkout'
    end

    it "I see a new order page with the details from my cart" do
      expect(current_path).to eq('/order/new')

      within "#item-#{@ogre.id}" do
        expect(page).to have_content(@ogre.name)
        expect(page).to have_content(@ogre.merchant.name)
        expect(page).to have_content(@ogre.price)
        expect(page).to have_content("2")
        expect(page).to have_content("$40.00")
      end
      expect(page).to have_content("$90.00")
    end

    it "I see a form for shipping information" do
      expect(current_path).to eq('/order/new')

      fill_in 'Name', with: "Billy Bob"
      fill_in 'Address', with: "123 Real St"
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: "80210"
      
      click_button 'Create Order'
    end

  end
end

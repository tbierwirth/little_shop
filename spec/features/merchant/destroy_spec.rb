require 'rails_helper'

RSpec.describe 'Destroy Existing Merchant' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it 'I can click button to destroy merchant from database' do
      visit "/merchants/#{@brian.id}"

      click_button 'Delete'

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@brian.name)
    end

    it "I get a flash message if a merchant has items that have been ordered" do
      visit items_path

      click_on 'Hippo'
      click_on 'Add To Cart'

      visit cart_path
      
      click_on 'Checkout'

      expect(current_path).to eq('/order/new')

      fill_in 'Name', with: "Billy Bob"
      fill_in 'Address', with: "123 Real St"
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: "80210"

      click_button 'Create Order'

      visit "/merchants/#{@brian.id}"
      click_on 'Delete'
      expect(page).to have_content("This merchant can not be deleted. One or more items from this merchant is in an order.")
    end

  end
end

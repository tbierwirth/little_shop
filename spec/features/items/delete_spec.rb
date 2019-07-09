require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      end

      it 'I can click a link to delete that item' do
        visit "/items/#{@giant.id}"

        click_link 'Delete'

        expect(current_path).to eq('/items')

        expect(page).to have_css("#item-#{@ogre.id}")
        expect(page).to have_css("#item-#{@hippo.id}")
        expect(page).to_not have_css("#item-#{@giant.id}")
      end

      it "I cant delete an item if it has been ordered" do
        visit items_path
        click_on "Ogre"
        click_on "Add To Cart"

        visit cart_path
        click_on "Checkout"

        fill_in 'Name', with: "Billy Bob"
        fill_in 'Address', with: "123 Real St"
        fill_in 'City', with: "Denver"
        fill_in 'State', with: "CO"
        fill_in 'Zip', with: "80210"

        click_button 'Create Order'

        visit items_path
        click_on "Ogre"
        click_link 'Delete'

        expect(page).to have_content("This item can not be deleted, it is currently being ordered.")
      end

      it "an item is removed from my cart after it is deleted" do
        visit items_path
        click_on "Ogre"
        click_on "Add To Cart"

        visit items_path
        click_on "Ogre"
        click_on "Delete"

        visit cart_path
        expect(page).to_not have_content(@ogre.name)
      end

    end
  end
end

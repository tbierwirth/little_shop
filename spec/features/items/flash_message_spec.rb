require 'rails_helper'

RSpec.describe 'Existing item Update Flash Message' do
 describe 'As a Visitor' do
   before :each do
     @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
     @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
   end
   describe 'Edit form Flash Messages' do

     it 'I see a flash message for a specific field not being filled: test 1' do
       visit "/items/#{@giant.id}/edit"

       name = 'Ogre'
       description = "I'm an Ogre!"
       price = 20
       image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
       inventory = 5

       # fill_in 'Name', with: name
       fill_in 'Description', with: description
       fill_in 'Price', with: price
       fill_in 'Image', with: image
       # fill_in 'Inventory', with: inventory
       click_button 'Update Item'

       expect(current_path).to eq("/items/#{@giant.id}")
       expect(page).to have_content("Name can't be blank, Inventory can't be blank")

     end

     it 'I see a flash message for a specific field not being filled: test 2' do
       visit "/items/#{@giant.id}/edit"

       name = 'Ogre'
       description = "I'm an Ogre!"
       price = 20
       image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
       inventory = 5

       fill_in 'Name', with: name
       fill_in 'Description', with: description
       # fill_in 'Price', with: price
       fill_in 'Image', with: image
       fill_in 'Inventory', with: inventory
       click_button 'Update Item'

       expect(current_path).to eq("/items/#{@giant.id}")
       expect(page).to have_content("Price can't be blank")
     end
   end

   describe "Creation form flash messages" do

     it 'I see a flash message for a specific field not being filled: test 3' do
       visit "/merchants/#{@megan.id}/items/new"

       name = 'Ogre'
       description = "I'm an Ogre!"
       price = 20
       image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
       inventory = 5

       # fill_in 'Name', with: name
       fill_in 'Description', with: description
       fill_in 'Price', with: price
       fill_in 'Image', with: image
       fill_in 'Inventory', with: inventory
       click_button 'Create Item'

       expect(current_path).to eq("/merchants/#{@megan.id}/items")
       expect(page).to have_content("Name can't be blank")

     end

     it 'I see a flash message for a specific field not being filled: test 4' do
       visit "/merchants/#{@megan.id}/items/new"

       name = 'Ogre'
       description = "I'm an Ogre!"
       price = 20
       image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
       inventory = 5

       
       click_button 'Create Item'

       expect(current_path).to eq("/merchants/#{@megan.id}/items")
       expect(page).to have_content("Name can't be blank, Description can't be blank, Price can't be blank, Image can't be blank, Inventory can't be blank")

     end
   end
 end
end

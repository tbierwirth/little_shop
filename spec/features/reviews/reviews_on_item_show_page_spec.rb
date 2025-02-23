require 'rails_helper'

RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
      @review2 = @giant.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
      @review3 = @giant.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")
      @review4 = @giant.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

    end

    it "I can see the items details and Reviews" do
      visit "/items/#{@giant.id}"

      expect(page).to have_content(@giant.name)
      expect(page).to have_content(@giant.description)
      expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@giant.inventory}")
      expect(page).to have_content("Sold by: #{@megan.name}")
      expect(page).to have_link(@megan.name)

      expect(page).to have_content(@review1.title)
      expect(page).to have_content(@review2.title)
      expect(page).to have_content(@review3.title)
      expect(page).to have_content(@review4.title)

      expect(page).to have_content(@review1.rating)
      expect(page).to have_content(@review2.rating)
      expect(page).to have_content(@review3.rating)
      expect(page).to have_content(@review4.rating)

      expect(page).to have_content(@review1.body)
      expect(page).to have_content(@review2.body)
      expect(page).to have_content(@review3.body)
      expect(page).to have_content(@review4.body)



    end
  end
end

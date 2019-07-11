RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
                @review_ogre1 = @ogre.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
                @review_ogre2 = @ogre.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
                @review_ogre3 = @ogre.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")
                @review_ogre4 = @ogre.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
                @review_giant1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
                @review_giant2 = @giant.reviews.create!(title: "Disappointed...", rating: 5, body: "Idk what I was expecting but I was disappointed.")
                @review_giant3 = @giant.reviews.create!(title: "Fair.", rating: 5, body: "Not thrilled or upset. Was as expected for price.")
                @review_giant4 = @giant.reviews.create!(title: "Pretty Good.", rating: 5, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      @human = @megan.items.create!(name: 'Human', description: "I'm a Human!", price: 25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 7000 )
                @review_human1 = @human.reviews.create!(title: "Damn!", rating: 4, body: "Definitely a Giant. No argument there")
                @review_human2 = @human.reviews.create!(title: "Disappointed...", rating: 4, body: "Idk what I was expecting but I was disappointed.")
                @review_human3 = @human.reviews.create!(title: "Fair.", rating: 4, body: "Not thrilled or upset. Was as expected for price.")
                @review_human4 = @human.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      @shoe = @megan.items.create!(name: 'Shoe', description: "I'm a Shoe!", price: 60, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 8 )
                @review_shoe1 = @shoe.reviews.create!(title: "Damn!", rating: 2, body: "Definitely a Giant. No argument there")
                @review_shoe2 = @shoe.reviews.create!(title: "Disappointed...", rating: 2, body: "Idk what I was expecting but I was disappointed.")
                @review_shoe3 = @shoe.reviews.create!(title: "Fair.", rating: 2, body: "Not thrilled or upset. Was as expected for price.")
                @review_shoe4 = @shoe.reviews.create!(title: "Pretty Good.", rating: 2, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      @eyeball = @megan.items.create!(name: 'Eyeball', description: "I'm a Eyeball!", price: 900, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 7 )
                @review_eyeball1 = @eyeball.reviews.create!(title: "Damn!", rating: 1, body: "Definitely a Giant. No argument there")
                @review_eyeball2 = @eyeball.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
                @review_eyeball3 = @eyeball.reviews.create!(title: "Fair.", rating: 1, body: "Not thrilled or upset. Was as expected for price.")
                @review_eyeball4 = @eyeball.reviews.create!(title: "Pretty Good.", rating: 1, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

      @book = @megan.items.create!(name: 'book', description: "I'm a book!", price: 5, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 54 )
                @review_book1 = @book.reviews.create!(title: "Damn!", rating: 0, body: "Definitely a Giant. No argument there")
                @review_book2 = @book.reviews.create!(title: "Disappointed...", rating: 0, body: "Idk what I was expecting but I was disappointed.")
                @review_book3 = @book.reviews.create!(title: "Fair.", rating: 0, body: "Not thrilled or upset. Was as expected for price.")
                @review_book4 = @book.reviews.create!(title: "Pretty Good.", rating: 0, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")


    end

    it "top 3 highest rated items for that merchant" do
      top_three_items = [@giant, @human, @ogre]

    end

  end
end



# As a visitor,
# When I visit an merchant's show page
# I see the top 3 highest rated items for that merchant (by average rating)

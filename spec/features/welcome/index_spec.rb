require "rails_helper"

RSpec.describe "welcome index page" do 
  before :each do
    @shelter_1 = Shelter.create(
      name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204"
    )

    @shelter_2 = Shelter.create(
      name: "Puppy Pound",
      address: "5608 N Eaton St.",
      city: "Chicago",
      state: "IL",
      zip: "80234"
    )

    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_2)
    @pet_3 = Pet.create(name: "Bella", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg", approximate_age: "3", sex: "female", shelter: @shelter_1)
  end

  it "displays all the shelters and pets" do
    
    visit "/"

    within("#welcome-index-shelters") do
      within("#shelter-#{@shelter_1.id}") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.address)
        expect(page).to have_content(@shelter_1.city)
        expect(page).to have_content(@shelter_1.state)
        expect(page).to have_content(@shelter_1.zip)
      end

      within("#shelter-#{@shelter_2.id}") do
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_2.address)
        expect(page).to have_content(@shelter_2.city)
        expect(page).to have_content(@shelter_2.state)
        expect(page).to have_content(@shelter_2.zip)
      end
    end
    
    within("#welcome-index-pets") do 
      within("#pet-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_1.approximate_age)
        expect(page).to have_content(@pet_1.sex)
        expect(page.find("img")['src']).to match(@pet_1.image)
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_2.approximate_age)
        expect(page).to have_content(@pet_2.sex)
        expect(page.find("img")['src']).to match(@pet_2.image)
      end
      
      within("#pet-#{@pet_3.id}") do
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_content(@pet_3.approximate_age)
        expect(page).to have_content(@pet_3.sex)
        expect(page.find("img")['src']).to match(@pet_3.image)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe "new application form" do
  before :each do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
    @pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)

    visit "/pets/#{@pet_1.id}"

    click_on "Add To Favorites"

    visit "/pets/#{@pet_2.id}"

    click_on "Add To Favorites"
  end

  it "allows user to select which favorited pets to apply for" do

    visit '/favorites'

    click_on "Adopt Pets"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)

    within "#pet-#{@pet_1.id}" do
      page.check("pet_ids[]")
    end

    within "#pet-#{@pet_2.id}" do
      page.check("pet_ids[]")
    end
  end

  it "has a form that user can fill out and submit application and pets applied for will no longer appear on favorites page" do

    visit '/favorites'

    click_on "Adopt Pets"

    within "#pet-#{@pet_1.id}" do
      page.check("pet_ids[]")
    end

    within "#pet-#{@pet_2.id}" do
      page.check("pet_ids[]")
    end

    fill_in "name", with: "Dylan"
    fill_in "address", with: "123 Main St"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip", with: "80203"
    fill_in "phone", with: "5555555555"
    fill_in "reason", with: "I love animals and my house is dog friendly."

    click_on "Apply For Pets"

    expect(current_path).to eq('/favorites')
    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to have_content("Application successfully submitted!")
  end
end

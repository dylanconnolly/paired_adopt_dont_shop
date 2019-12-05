require 'rails_helper'

RSpec.describe "favorite pets index page", type: :feature do
  it "user can see all pets they have favorited with the pet name and image" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")


    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)

    visit "/pets/#{pet_1.id}"
    click_on "Add To Favorites"

    visit "/pets/#{pet_2.id}"
    click_on "Add To Favorites"

    visit '/favorites'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.img)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.img)
  end
end

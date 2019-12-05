require 'rails_helper'

RSpec.describe "favorite pets index page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")


      @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
      @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_1)
      @pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
  end

  it "user can see all pets they have favorited with the pet name and image" do


    visit "/pets/#{@pet_1.id}"
    click_on "Add To Favorites"

    visit "/pets/#{@pet_2.id}"
    click_on "Add To Favorites"

    visit '/favorites'

    expect(page).to have_link(@pet_1.name)
    expect(page).to have_css("img[src='#{@pet_1.image}']")
    expect(page).to have_link(@pet_2.name)
    expect(page).to have_css("img[src='#{@pet_1.image}']")
    expect(page).to_not have_link(@pet_3.name)
    expect(page).to_not have_css("img[src='#{@pet_3.image}']")
  end

  it "user can click on favorite pets counter and be taken to favorites page" do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")


    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_1)

    visit "/pets/#{@pet_1.id}"
    click_on "Add To Favorites"

    visit "/shelters"
    click_on "Favorites: 1"

    expect(current_path).to eq("/favorites")
    expect(page).to have_link(@pet_1.name)

    visit "/pets/#{@pet_2.id}"
    click_on "Add To Favorites"

    visit "/"
    click_on "Favorites: 2"

    expect(current_path).to eq("/favorites")
  end

  it "has a remove button next to each pet to remove that pet from favorites" do

  end
end

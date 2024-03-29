require 'rails_helper'

RSpec.describe "when user favorites a pet", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_1)
  end

  it "they see message flash confirmation and the favorites counter increases by one" do

    visit "/pets/#{@pet_1.id}"

    click_on "Add To Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("You have added #{@pet_1.name} to your favorites!")
    expect(page).to have_content("Favorites: 1")

    visit "/pets/#{@pet_2.id}"

    click_on "Add To Favorites"

    expect(page).to have_content("You have added #{@pet_2.name} to your favorites!")
    expect(page).to have_content("Favorites: 2")
  end

  it "the user no longer sees link to favorite pet but sees link to remove pet from favorites" do
    visit "/pets/#{@pet_1.id}"

    click_on "Add To Favorites"

    expect(page).to have_content("Favorites: 1")

    click_on "Remove From Favorites"

    expect(page).to have_content("You have removed #{@pet_1.name} from your favorites.")
    expect(page).to have_content("Favorites: 0")
    expect(page).to have_link("Add To Favorites")
  end

end

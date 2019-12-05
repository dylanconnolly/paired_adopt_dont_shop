require 'rails_helper'

RSpec.describe "when user favorites a pet", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
  end

  it "they see message that the pet was added to their favorites and are taken back to pet show page" do

    visit "/pets/#{@pet_1.id}"

    click_on "Add To Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Pet was added to your favorites!")
    expect(page).to have_content("Favorites: 1")
  end


end

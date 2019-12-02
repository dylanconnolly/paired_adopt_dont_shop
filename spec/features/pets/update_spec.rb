require 'rails_helper'

RSpec.describe "edit pet form" do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
  end

  it "has fields the user can use to update pet info" do

    visit "/pets/#{@pet_1.id}/edit"

    fill_in :name, with: "Ned"
    fill_in :approximate_age, with: "1"
    fill_in :description, with: "Yung boy"

  end

  it "has a submit button that will redirect to the pet show page with the updated info" do

    visit "/pets/#{@pet_1.id}/edit"

    fill_in :name, with: "Ned"
    fill_in :approximate_age, with: "1"
    fill_in :description, with: "Yung boy"

    click_button("Update Details")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Ned")
    expect(page).to have_content("Yung boy")
    expect(page).to_not have_content("Rufus")
  end
end

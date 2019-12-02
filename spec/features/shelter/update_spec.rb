require 'rails_helper'

RSpec.describe "shelter show page", type: :feature do
  it "has a button to edit shelter" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    visit "/shelters/#{shelter_1.id}"

    click_link("Edit Shelter")

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/edit")
  end

  it "user can update fields and click submit" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    visit "/shelters/#{shelter_1.id}/edit"

    fill_in "name", with: "I changed this name"
    fill_in "address", with: "1820 Fake Blvd"

    expect(page).to have_field ("city")
    expect(page).to have_field ("state")
    expect(page).to have_field ("zip")

    click_button("Update Shelter")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("I changed this name")
  end
end

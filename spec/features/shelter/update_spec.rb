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
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip", with: "23083"

    click_button("Update Shelter")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("I changed this name")
  end

  it "user sees error message if they try to update form with incomplete info" do

    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

      visit "/shelters/#{shelter_1.id}/edit"

      fill_in "name", with: "I changed this name"
      fill_in "address", with: "1820 Fake Blvd"
      fill_in "city", with: "Denver"
      fill_in "state", with: "CO"
      fill_in "zip", with: ""

      click_button("Update Shelter")

      expect(page).to have_content("Please complete all fields on the form.")

      fill_in "name", with: "I changed this name"
      fill_in "address", with: "1820 Fake Blvd"
      fill_in "city", with: ""
      fill_in "state", with: ""
      fill_in "zip", with: ""

      click_button("Update Shelter")

      expect(page).to have_content("Please complete all fields on the form.")
  end
end

require 'rails_helper'

RSpec.describe "new review page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")
  end

  it "user can fill in form and submit to create new shelter review" do

    visit "/shelters/#{@shelter_1.id}/new_review"

    fill_in "title", with: "Awesome place"
    fill_in "rating", with: 5
    fill_in "content", with: "Has the best dogs"
    fill_in "img", with: "fake_img.img"

    click_on "Create Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Awesome place")
    expect(page).to have_content("5")
    expect(page).to have_content("Has the best dogs")
    find("img[src='fake_img.img']")
  end

  it "should show an error message if user fails to input title, rating, or content" do

    visit "/shelters/#{@shelter_1.id}/new_review"

    fill_in "title", with: "Bad spot"

    click_on "Create Review"

    expect(page).to have_content("Unable to create review: missing required fields")
  end
end

require 'rails_helper'

RSpec.describe "new pet view" do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
  end

  it "has a form where user can create a new pet" do

    visit "/shelters/#{@shelter_1.id}/pets/new"

    fill_in "image", with: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg"
    fill_in "name", with: "Catalina"
    fill_in "description", with: "lovely little pupper"
    fill_in "approximate_age", with: "6"
    select "female", :from => :sex
  end

  it "it redirects to /shelters/:id/pets after user clicks submit" do

    visit "/shelters/#{@shelter_1.id}/pets/new"

    fill_in "image", with: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg"
    fill_in "name", with: "Catalina"
    fill_in "description", with: "lovely little pupper"
    fill_in "approximate_age", with: "6"
    select "female", :from => :sex

    click_button "Add Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

    expect(page).to have_content("Catalina")
    find("img[src='https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg']")
  end
end

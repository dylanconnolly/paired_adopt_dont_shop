require 'rails_helper'

RSpec.describe "shelter index page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")

    @shelter_2 = Shelter.create(name: "Puppy Pound",
      address: "5608 N Eaton St.",
      city: "Chicago",
      state: "IL",
      zip: "80234")

    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_2)
    @pet_3 = Pet.create(name: "Bella", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg", approximate_age: "3", sex: "female", shelter: @shelter_1, adoptable: false)
  end

  it "can see all shelter names" do

    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)

    expect(page).to have_content(@shelter_2.name)
  end

  it "has an edit link for each shelter and link takes user to that shelter's edit form" do

    visit "/shelters"

    click_link("Edit", match: :first)

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "has a link for each shelter to delete the shelter" do

    visit "/shelters"

    within("section[id='#{@shelter_1.id}']") do
    click_link("Delete")
    expect(current_path).to eq("/shelters")
    end

    visit "/shelters"

    within("section[id='#{@shelter_2.id}']") do
    click_link("Delete")
    end
    expect(page).to_not have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
  end

  it "links to each shelter if the name is clicked" do
    visit '/shelters'

    click_link("#{@shelter_1.name}")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    visit '/shelters'
    click_link("#{@shelter_1.name}")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
  end
end

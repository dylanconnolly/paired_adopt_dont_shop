require 'rails_helper'

RSpec.describe "shelter pet index", type: :feature do
  before :each do

    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")

    @shelter_2 = Shelter.create(name: "Rodeo Roundup Soundup Pupps",
      address: "5608 N Eaton St.",
      city: "Chicago",
      state: "IL",
      zip: "80234")

    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_2)
    @pet_3 = Pet.create(name: "Bella", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg", approximate_age: "3", sex: "female", shelter: @shelter_1, adoptable: false)
  end

  it "lists the shelter's adoptable pets and their details" do

    visit "/shelters/#{@shelter_1.id}/pets"

    find("img[src='https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)

    visit "/shelters/#{@shelter_2.id}/pets"

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.approximate_age)
  end

  it "does not display pets that are pending adoption" do

    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to_not have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_3.sex)
  end

  it "has a link to create a new pet" do

    visit "/shelters/#{@shelter_1.id}/pets"

    click_link("New Pet")

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
  end

  it "has a link to edit next to each pet" do

    pet_4 = Pet.create(name: "Dillard", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}/pets"

    within("section[id='links #{@pet_1.id}']") do
      click_link("Edit Pet")
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    visit "/shelters/#{@shelter_1.id}/pets"

    within("section[id='links #{pet_4.id}']") do
      click_link("Edit Pet")
      expect(current_path).to eq("/pets/#{pet_4.id}/edit")
    end
  end

  it "has a link to delete next to each pet" do

    pet_4 = Pet.create(name: "Dillard", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}/pets"

    within("section[id='links #{@pet_1.id}']") do
      click_link("Delete Pet")
      expect(current_path).to eq("/pets")
    end

    visit "/shelters/#{@shelter_1.id}/pets"

    within("section[id='links #{pet_4.id}']") do
      click_link("Delete Pet")
    end

    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(pet_4.name)
  end

  it "the pet name links to the pet show page" do

    pet_4 = Pet.create(name: "Dillard", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}/pets"

    click_link("Rufus")

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/shelters/#{@shelter_1.id}/pets"

    click_link("Dillard")

    expect(current_path).to eq("/pets/#{pet_4.id}")
  end
end

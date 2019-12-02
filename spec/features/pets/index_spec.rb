require 'rails_helper'

RSpec.describe "pets index", type: :feature do
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
  end

  it "lists all pets with their details" do

    visit '/pets'

    find("img[src='https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@shelter_1.name)

    find("img[src='https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg']")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_content(@pet_2.approximate_age)
    expect(page).to have_content(@shelter_2.name)
  end

  it "has a link to edit pet next to each pet on page" do

    visit '/pets'

    within("section[id='links #{@pet_1.id}']") do
      click_link("Edit Pet")
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    visit '/pets'

    within("section[id='links #{@pet_2.id}']") do
      click_link("Edit Pet")
      expect(current_path).to eq("/pets/#{@pet_2.id}/edit")
    end
  end

  it "has a link to delete a pet next to each pet" do

    visit '/pets'

    within("section[id='links #{@pet_1.id}']") do
      click_link("Delete Pet")
      expect(current_path).to eq("/pets")
    end

    visit '/pets'

    within("section[id='links #{@pet_2.id}']") do
      click_link("Delete Pet")
    end

    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_2.name)
  end

  it "the shelter name for each pet links to that shelter's show page" do

    visit '/pets'

    click_link("#{@shelter_1.name}")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
  end

  it "the name of the pet links to that pet's show page" do

    visit "/pets"

    click_link("Rufus")

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/pets"

    click_link("Peter")

    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
end

require 'rails_helper'

RSpec.describe "show pets page", type: :feature do
  it "displays the pet's details" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    shelter_2 = Shelter.create(name: "Rodeo Roundup Soundup Pupps",
                              address: "5608 N Eaton St.",
                              city: "Chicago",
                              state: "IL",
                              zip: "80234")

    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_2)

    visit "/pets/#{pet_1.id}"

    find("img[src='https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.adoptable)
    expect(page).to_not have_content(pet_2.name)

    visit "/pets/#{pet_2.id}"

    find("img[src='https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.description)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content(pet_2.adoptable)
    expect(page).to_not have_content(pet_1.name)
  end

  it "has a button to edit the pet's info" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)

    visit "/pets/#{pet_1.id}"

    click_link("Edit Pet")

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")
  end
end

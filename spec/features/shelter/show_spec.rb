require 'rails_helper'

RSpec.describe "individual shelter page", type: :feature do
  it "can see all attributes of shelter" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    shelter_2 = Shelter.create(name: "Puppy Pound",
                               address: "5608 N Eaton St.",
                               city: "Chicago",
                               state: "IL",
                               zip: "80234")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)

    visit "/shelters/#{shelter_2.id}"

    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_2.address)
    expect(page).to have_content(shelter_2.city)
    expect(page).to have_content(shelter_2.state)
    expect(page).to have_content(shelter_2.zip)
  end

  it "has a link to view pets of that shelter" do

    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")

    visit "/shelters/#{shelter_1.id}"

    click_link("View Pets")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
  end

  it "has a stastics area for shelter stats" do
    shelter = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter)
    pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter)
    pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter)

    review_1 = shelter_1.shelter_reviews.create(title: "Good spot", rating: 4, content: "Lovely place down the street with cute dogs")
    review_2 = shelter_1.shelter_reviews.create(title: "THE BEST", rating: 5, content: "THE BEST woooooo")

    application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")
    application_2 = Application.create!(name: "Bob", address: "1123123 Main", city: "Pawnee", state: "IN", zip: "28383", phone: "123555555", reason: "I am person")
    application_3 = Application.create!(name: "Bobert", address: "18293 Main", city: "Somewhere", state: "CA", zip: "28383", phone: "123555555", reason: "Person place")

    application.pets << pet_1
    application.pets << pet_2
    application_2.pets << pet_1

    #count of pets that are at that shelter
    # average shelter review rating
    # number of applications on file for that shelter

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content("Pets: 3")
    expect(page).to have_content("Average rating: 4.5")
    expect(page).to have_content("Applications: 2")
  end
end

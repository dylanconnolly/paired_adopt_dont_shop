require 'rails_helper'

RSpec.describe "application show page" do
  before :each do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
    @pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)

    @application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")
    @application_2 = Application.create!(name: "Bob", address: "1123123 Main", city: "Pawnee", state: "IN", zip: "28383", phone: "123555555", reason: "I am person")

    @application.pets << @pet_1
    @application.pets << @pet_2
    @application_2.pets << @pet_1
    @application_2.pets << @pet_2
  end

  it "lists details of application and link to each pet on the application" do

    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.phone)
    expect(page).to have_content(@application.reason)

    within "#pet-#{@pet_1.id}" do
      expect(page).to have_link(@pet_1.name)
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_link(@pet_2.name)
    end

    expect(page).to_not have_css("#pet-#{@pet_3.id}")
  end

  it "has a link to approve the application for each pet listed on the app" do

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Adoptable: false")
    expect(page).to have_content("(On hold for #{@application.name}.)")

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_link("Approve Adoption")
    end
  end

  it "allows user to be approved for any number of pets on the application" do

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve Adoption"
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Adoptable: false")
    expect(page).to have_content("(On hold for #{@application.name}.)")

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_2.id}" do
      click_link "Approve Adoption"
    end
    expect(current_path).to eq("/pets/#{@pet_2.id}")
    expect(page).to have_content("Adoptable: false")
    expect(page).to have_content("(On hold for #{@application.name}.)")
  end

  it "hides ability to approve application for a pet if that pet has already been adopted" do

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve Adoption"
    end

    visit "/applications/#{@application_2.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to_not have_link("Approve Adoption")
    end

    within "#pet-#{@pet_2.id}" do
      click_link "Approve Adoption"
    end

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to_not have_link("Approve Adoption")
    end
  end

  it "gives the ability to revoke an approved application for a pet" do

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve Adoption"
    end

    visit "/applications/#{@application_2.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to_not have_link("Approve Adoption")
      expect(page).to_not have_link("Unapprove Adoption")
    end

    within "#pet-#{@pet_2.id}" do
      click_link "Approve Adoption"
    end

    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to have_link("Unapprove Adoption")
      expect(page).to_not have_link("Approve Adoption")
    end
  end
end

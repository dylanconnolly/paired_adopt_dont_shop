require 'rails_helper'

RSpec.describe "applications index" do
  before :each do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
    @pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
    @pet_4 = Pet.create(name: "Doge", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)

    @application_1 = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")
    @application_2 = Application.create!(name: "Steve", address: "1273 Main", city: "Chicago", state: "IL", zip: "23832", phone: "12312314", reason: "I am bad owner")
    @application_3 = Application.create!(name: "Bobert", address: "109481029 Main", city: "Fargo", state: "ND", zip: "78273", phone: "1234345555", reason: "I am ok owner")

    @application_1.pets << @pet_1
    @application_1.pets << @pet_2
    @application_2.pets << @pet_1

    @application_3.pets << @pet_3
  end

  it "pet show page has link to show name of all applicants for that pet" do

    visit "pets/#{@pet_1.id}"

    within "#applications" do
      expect(page).to have_link("#{@application_1.name}")
      expect(page).to have_link("#{@application_2.name}")
      expect(page).to_not have_link("#{@application_3.name}")
      click_on "#{@application_1.name}"
    end

    expect(current_path).to eq("/applications/#{@application_1.id}")
  end

  it "if there are no applications for pet, user sees message stating such" do

    visit "pets/#{@pet_4.id}"

    within "#applications" do
      expect(page).to have_content("There are no applications to adopt this pet.")
    end
  end
end

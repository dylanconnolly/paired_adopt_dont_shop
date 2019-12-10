require 'rails_helper'

RSpec.describe "pet applications update action" do
  before :each do
    @shelter_1 = Shelter.create(name: "Blue Blue Barky",
                               address: "123 This Way",
                               city: "Denver",
                               state: "CO",
                               zip: "90204")
    @pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)
    @pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: @shelter_1)

    @application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")

    @application.pets << @pet_1
    @application.pets << @pet_2

    @pet_application_for_pet_1 = PetApplication.find_by(pet_id: @pet_1.id, application_id: @application.id)
    @pet_application_for_pet_2 = PetApplication.find_by(pet_id: @pet_2.id, application_id: @application.id)
  end
  it "changes pet application approved column to true" do

    visit "/applications/#{@application.id}"

    expect(@pet_application_for_pet_1.approved).to eq(false)
    expect(@pet_application_for_pet_2.approved).to eq(false)

    within "#pet-#{@pet_1.id}" do
      click_link "Approve Adoption"
    end

    expect(PetApplication.find(@pet_application_for_pet_1.id).approved).to eq(true)
    expect(PetApplication.find(@pet_application_for_pet_2.id).approved).to eq(false)
  end
end

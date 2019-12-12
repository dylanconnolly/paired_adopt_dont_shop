require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :approximate_age}
  end

  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "deleting pet" do
    it "deleted pet_applications related to it" do
      shelter = Shelter.create(name: "Blue Blue Barky",
                                 address: "123 This Way",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "90204")
      pet = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter)

      application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")

      pet_app = PetApplication.create!(pet_id: pet.id, application_id: application.id)

      pet.destroy
      expect { pet_app.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  it "defaults adoptable to true" do
    pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: @shelter_1)


    expect(pet_1.adoptable).to eq(true)
  end

  describe "#application_ids" do
    it "returns the id's for all applications for given pet" do

      shelter = Shelter.create(name: "Blue Blue Barky",
                                 address: "123 This Way",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "90204")

      pet = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter)

      application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")
      application_2 = Application.create!(name: "Greg", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am a owner")

      application.pets << pet
      application_2.pets << pet

      expect(pet.application_ids)

    end
  end

  describe "#deletable?" do
    it "queries the database to see if pet has any approved applications" do

      shelter = Shelter.create(name: "Blue Blue Barky",
                                 address: "123 This Way",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "90204")

      pet = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter)

      application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")

      application.pets << pet

      pet_app = PetApplication.create!(pet_id: pet.id, application_id: application.id, approved: true)

      expect(pet.deletable?).to eq(false)

      pet_app.update(approved: false)

      expect(pet.deletable?).to eq(true)
    end
  end
end

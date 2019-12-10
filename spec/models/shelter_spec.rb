require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :shelter_reviews}
  end

  it "when shelter is deleted pets belonging to shelter are deleted too" do
    shelter_1 = Shelter.create(name: "Blue Blue Barky",
      address: "123 This Way",
      city: "Denver",
      state: "CO",
      zip: "90204")

      pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
      pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)

    shelter_1.destroy

    expect { pet_1.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { pet_2.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  describe "deleting shelter" do
    it "deletes all shelter_reviews associated with it" do
      shelter_1 = Shelter.create(name: "Blue Blue Barky",
        address: "123 This Way",
        city: "Denver",
        state: "CO",
        zip: "90204")

      review_1 = shelter_1.shelter_reviews.create(title: "Good spot", rating: 4, content: "Lovely place down the street with cute dogs")
      review_2 = shelter_1.shelter_reviews.create(title: "THE BEST", rating: 5, content: "THE BEST woooooo")

      shelter_1.destroy

      expect { review_1.reload }.to raise_error ActiveRecord::RecordNotFound
      expect { review_2.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "#pets_with_approved_applications" do
    it "returns an array of pet objects that have approved applications" do
      shelter_1 = Shelter.create(name: "Blue Blue Barky",
        address: "123 This Way",
        city: "Denver",
        state: "CO",
        zip: "90204")

        pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
        pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
        pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)

        application = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")

        application.pets << pet_1
        application.pets << pet_2
        application.pets << pet_3

        expect(shelter_1.pets_with_approved_applications).to eq([])

        pet_app_1 = PetApplication.find_app(pet_1.id, application.id)
        pet_app_1.update(approved: true)
        pet_app_2 = PetApplication.find_app(pet_2.id, application.id)
        pet_app_2.update(approved: true)

        expect(shelter_1.pets_with_approved_applications).to eq([pet_1, pet_2])
    end
  end

  describe "statistics methods" do
    describe "#count_of_pets" do
      it "returns total number of pets at shelter" do

        shelter_1 = Shelter.create(name: "Blue Blue Barky",
          address: "123 This Way",
          city: "Denver",
          state: "CO",
          zip: "90204")
        shelter_2 = Shelter.create(name: "Some Kinda Shelter",
          address: "123 iadsfjh",
          city: "Juneau",
          state: "AK",
          zip: "09238")

          pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
          pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
          pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_2)

        expect(shelter_1.count_of_pets).to eq(2)
        expect(shelter_2.count_of_pets).to eq(1)
      end
    end

    describe "#average_rating" do
      it "returns average shelter_reviews rating" do

        shelter_1 = Shelter.create(name: "Blue Blue Barky",
          address: "123 This Way",
          city: "Denver",
          state: "CO",
          zip: "90204")

          review_1 = shelter_1.shelter_reviews.create(title: "Good spot", rating: 4, content: "Lovely place down the street with cute dogs")
          review_2 = shelter_1.shelter_reviews.create(title: "THE BEST", rating: 5, content: "THE BEST woooooo")
          review_3 = shelter_1.shelter_reviews.create(title: "Awful", rating: 1, content: "This place only had cats. They're the worst.")
          review_4 = shelter_1.shelter_reviews.create(title: "Awful", rating: 0, content: "This place only had cats. They're the worst.")

        expect(shelter_1.average_rating).to eq(2.5)
      end
    end

    describe "#count_of_applications" do
      it "returns number of applications the shelter has" do

        shelter_1 = Shelter.create(name: "Blue Blue Barky",
          address: "123 This Way",
          city: "Denver",
          state: "CO",
          zip: "90204")
        shelter_2 = Shelter.create(name: "Some Kinda Shelter",
          address: "123 iadsfjh",
          city: "Juneau",
          state: "AK",
          zip: "09238")

          pet_1 = Pet.create(name: "Rufus", image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg", approximate_age: "4", sex: "male", shelter: shelter_1)
          pet_2 = Pet.create(name: "Peter", image: "https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg", approximate_age: "1", sex: "male", shelter: shelter_1)
          pet_3 = Pet.create(name: "Matt", image: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_960_720.jpg", approximate_age: "4", sex: "male", shelter: shelter_2)

          application_1 = Application.create!(name: "Dylan", address: "123 Main", city: "Denver", state: "CO", zip: "80203", phone: "555555", reason: "I am good owner")
          application_2 = Application.create!(name: "Steve", address: "1273 Main", city: "Chicago", state: "IL", zip: "23832", phone: "12312314", reason: "I am bad owner")
          application_3 = Application.create!(name: "Bobert", address: "109481029 Main", city: "Fargo", state: "ND", zip: "78273", phone: "1234345555", reason: "I am ok owner")

          application_1 << pet_1
          application_2 << pet_1
          application_3 << pet_3
          application_3 << pet_2

        expect(shelter_1.count_of_applications).to eq(3)
        expect(shelter_2.count_of_applications).to eq(1)
      end
    end
  end
end

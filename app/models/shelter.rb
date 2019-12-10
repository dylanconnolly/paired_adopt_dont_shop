class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :destroy

  def pets_with_approved_applications
    self.pets.find_all do |pet|
      PetApplication.pet_adopted?(pet) == true
    end
  end

  def count_of_pets
    pets.count
  end

  def average_rating
    shelter_reviews.average(:rating)
  end
end
